#!/usr/bin/env python3
"""Patch the generated Typst export, then compile the PDF.

Two fixes on top of MyST's Typst export (see build-notes.md):

1. Glyph mangling — the exporter rewrites a handful of Unicode characters in
   prose and html-derived output text into symbol names (`→`→`arrow.r`,
   `×`→`$times$`). Inside raw/code blocks the characters survive intact, so
   only prose text needs patching.

2. Output panels — the exporter emits code-cell *input* as ```apl fences and
   cell *output* as bare ``` fences, indistinguishable from prose fenced
   blocks. Retag output fences as ```output so the template's show rules can
   frame them as green panels (inputs get blue panels via lang "apl").

3. Blank pages — the exporter inserts a hard #pagebreak() before every
   article. When the previous article ends exactly at the bottom of a page
   the double break leaves an empty page; weaken the breaks so they are
   skipped on pages that are already empty.

4. Float-right diagrams — the notebooks mark composition diagrams (atop,
   fork, over, behind, cos) with :class: fig-float-right, which the site's
   CSS floats to the right so prose wraps beside them. The Typst exporter
   drops the class and emits a bare left-aligned #image(...); rewrite those
   calls as wrap-content(fig, [paragraph]) so the image sits at the right
   of its first paragraph, like the site.

5. Illustration sizes — the exporter renders every markdown image at
   width: 90%, which blows up small diagrams beyond their native pixel
   resolution (pixelated) and lets illustrations dominate the page. Clamp
   each image to min(90%, 60%, native width), i.e. never upscale a bitmap
   past its own pixels, and cap everything at 60% of the content width.

6. Glued blocks — the exporter sometimes emits a block-level element (heading,
   image, fence) directly after the closing bracket of another element, with
   no newline in between (e.g. `...])]== Who is this for?`). Typst only
   recognises headings at the start of a line, so such text renders literally.
   Split the pair with a blank line.

Run from the repository root after `jupyter book build --typst`; the compiled
PDF overwrites exports/book.pdf.
"""

import glob
import os
import re
import subprocess
import sys

REPLACEMENTS = {
    "arrow.r": "→",
    "arrow.l": "←",
    "$times$": "×",
    "$eq.not$": "≠",
    "$tilde$": "∼",
    "$infty$": "∞",
}

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Image basenames that carry :class: fig-float-right in the notebooks (see
# docstring, item 4). MyST hashes the filenames, so match on the stem.
FLOAT_IMAGES = (
    r"atop|fork|behind|dyadic-behind|over|cos",
)
FLOAT_IMAGE_RE = re.compile(
    r'#image\("files/(?:%s)-[a-f0-9]+\.svg", width: ([\d.]+)%%\)'
    % FLOAT_IMAGES
)
# A4 page (595.3pt) minus the template's 20% left and 10% right margins:
# the width that MyST's `width: N%` resolves against at top level.
CONTENT_WIDTH_PT = 595.3 * 0.70

WRAP_IMPORT = '#import "wrap-it.typ": wrap-content'
WRAP_GUTTER = "1.4em"

# Illustrations are emitted at width: 90% of the content width; cap them at
# 60% and never upscale a bitmap past its own pixels (see docstring, item 5).
IMAGE_CAP_PERCENT = 60.0


def image_pixel_width(path: str) -> int | None:
    """Read the pixel width from PNG/JPEG/GIF headers (no PIL needed)."""
    ext = os.path.splitext(path)[1].lower()
    with open(path, "rb") as f:
        head = f.read(64)
    if ext == ".png" and head[:8] == b"\x89PNG\r\n\x1a\n":
        return int.from_bytes(head[16:20], "big")
    if ext in (".jpg", ".jpeg") and head[:2] == b"\xff\xd8":
        with open(path, "rb") as f:
            head = f.read(65536)
        i = 2
        while i < len(head) - 2:
            if head[i] != 0xFF:
                i += 1
                continue
            if head[i + 1] in (0xC0, 0xC1, 0xC2):
                return int.from_bytes(head[i + 7 : i + 9], "big")
            i += 2 + int.from_bytes(head[i + 2 : i + 4], "big")
    if ext == ".gif" and head[:6] in (b"GIF87a", b"GIF89a"):
        return int.from_bytes(head[6:8], "little")
    return None


def clamp_image_widths(text: str, files_dir: str) -> tuple[str, int]:
    """Scale illustrations down to their native pixel width, capped at 60%."""
    lines = text.split("\n")
    changed = 0
    for i, line in enumerate(lines):
        m = re.search(r'#image\("files/([^"]+)", width: ([\d.]+)%\)', line)
        if not m:
            continue
        name, pct = m.group(1), float(m.group(2))
        if pct <= 0:
            continue
        px = image_pixel_width(os.path.join(files_dir, name))
        if px is None:
            continue
        native = px / CONTENT_WIDTH_PT * 100
        new = min(pct, IMAGE_CAP_PERCENT, native)
        if new == pct:
            continue
        replaced = line.replace(f"width: {m.group(2)}%", f"width: {new:.1f}%")
        if replaced == line:
            continue
        lines[i] = replaced
        changed += 1
    return "\n".join(lines), changed


def newest_temp_dir() -> str:
    dirs = sorted(
        glob.glob(os.path.join(ROOT, "contents", "_build", "temp", "myst*")),
        key=os.path.getmtime,
        reverse=True,
    )
    if not dirs:
        sys.exit("no _build/temp/myst* directory found — run 'jupyter book build --typst' first")
    return dirs[0]


def tag_outputs(text: str) -> tuple[str, int]:
    """Retag bare fenced blocks that follow an ```apl input cell as ```output."""
    lines = text.split("\n")
    inside = False
    expecting = False
    tagged = 0
    for i, line in enumerate(lines):
        if line.startswith("```"):
            if not inside:
                lang = line[3:].strip()
                if lang == "":
                    if expecting:
                        lines[i] = "```output"
                        tagged += 1
                elif lang == "apl":
                    expecting = True
                else:
                    expecting = False
                inside = True
            else:
                inside = False
        elif not inside and line.strip():
            expecting = False
    return "\n".join(lines), tagged


GLUE_RE = re.compile(r"\](?=={1,4}\s|#image\(|#quote\(|#noteBlock\(|```)")


def split_glued_blocks(text: str) -> tuple[str, int]:
    """Insert a blank line after a `]` glued to a block-level element."""
    return re.subn(GLUE_RE, "]\n\n", text)


def wrap_float_images(text: str) -> tuple[str, int]:
    """Float right-aligned diagrams and wrap their first paragraph beside them."""
    lines = text.split("\n")
    out: list[str] = []
    wrapped = 0
    i = 0
    while i < len(lines):
        line = lines[i]
        m = FLOAT_IMAGE_RE.search(line)
        if not m:
            out.append(line)
            i += 1
            continue
        prefix = line[: m.start()]
        if prefix.strip():
            out.append(prefix)
        width_pt = round(float(m.group(1)) * CONTENT_WIDTH_PT / 100, 1)
        image = line[m.start() : m.end()].replace(
            f"width: {m.group(1)}%", f"width: {width_pt}pt"
        )
        i += 1
        while i < len(lines) and not lines[i].strip():
            i += 1
        para = lines[i].strip() if i < len(lines) else ""
        if not para or para.startswith(("#", "```", "]")):
            # No prose immediately after the diagram (or it isn't a paragraph):
            # fall back to a right-aligned image with the text below it.
            out.append(f"#align(right, {image})")
            continue
        i += 1
        out.append(f"#wrap-content(\n  [{image}],\n  align: top + right,\n  columns: (1fr, auto),\n  column-gutter: {WRAP_GUTTER},\n  [\n    {para}\n  ],\n)")
        wrapped += 1
    text = "\n".join(out)
    if wrapped:
        text = text.replace(
            '#import "myst-imports.typ": *',
            f'#import "myst-imports.typ": *\n{WRAP_IMPORT}',
            1,
        )
    return text, wrapped


def main() -> None:
    temp = newest_temp_dir()
    files_dir = os.path.join(temp, "files")
    patterns = [re.compile(re.escape(k)) for k in REPLACEMENTS]
    total_tagged = 0
    total_wrapped = 0
    total_glued = 0
    total_clamped = 0
    for path in sorted(glob.glob(os.path.join(temp, "*.typ"))):
        if os.path.basename(path) in ("style.typ", "aside_style.typ"):
            continue
        text = open(path, encoding="utf-8").read()
        orig = text
        for pat in patterns:
            text = pat.sub(lambda m: REPLACEMENTS[m.group(0)], text)
        text = text.replace("#pagebreak()", "#pagebreak(weak: true)")
        text, tagged = tag_outputs(text)
        total_tagged += tagged
        text, wrapped = wrap_float_images(text)
        total_wrapped += wrapped
        text, glued = split_glued_blocks(text)
        total_glued += glued
        text, clamped = clamp_image_widths(text, files_dir)
        total_clamped += clamped
        if text != orig:
            open(path, "w", encoding="utf-8").write(text)
            print(f"patched {os.path.basename(path)} (tagged {tagged} outputs, wrapped {wrapped} diagrams, split {glued} glued blocks, clamped {clamped} images)")
    print(f"tagged {total_tagged} output blocks")
    print(f"wrapped {total_wrapped} float-right diagrams")
    print(f"split {total_glued} glued blocks")
    print(f"clamped {total_clamped} illustration widths")

    out = os.path.join(ROOT, "contents", "exports", "book.pdf")
    subprocess.run(
        ["typst", "compile", "book.typ", out],
        cwd=temp,
        check=True,
    )
    print(f"PDF: {out}")


if __name__ == "__main__":
    main()
