#!/usr/bin/env python3
"""Patch the bundled MyST typst exporter so iframe embeds link to their source.

A `:::{iframe} <url>` directive (used in ride.ipynb for the embedded YouTube
walkthroughs) falls back, in the typst/PDF path, to its `:placeholder:` still
image. The `iframe` handler renders that placeholder as a bare `#image(...)`
and never looks at `node3.src` (the actual video URL) at all -- so the PDF
reader gets a static frame with no way to reach the video, while the site
shows a live, clickable embed. Same class of bug as the `<kbd>` and link-
destination issues: the typst renderer does something *technically not
broken* but silently worse than the source implies, and the export still
exits 0.

Fixed by wrapping the placeholder image in a link to `node3.src`, so the
still frame in the PDF is clickable through to the actual video, escaped for
Typst string-literal syntax (backslash, quote) the same way link destinations
are handled elsewhere.

`node3.src` for a YouTube embed is the `/embed/<id>` form required inside an
`<iframe>` -- it needs a parent-page/JS context to actually play, so opened
directly (as a PDF reader would) it doesn't behave like a normal watch page.
The patch rewrites that specific form to the standard `/watch?v=<id>` URL,
which is what every other YouTube link in the book already uses, and leaves
any non-YouTube iframe source untouched.

There is no config option for this, so we patch the exporter bundle in the
venv, alongside `patch-mystmd-outputs.py`, `patch-typst-keyboard.py` and
`patch-typst-links.py`.

Run from the repository root. Safe to run on every build — if the bundle is
already patched it exits 0; if the bundle no longer matches (version drift) it
refuses rather than guessing.
"""

import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BUNDLE = os.path.join(
    ROOT, ".venv", "lib", "python3.12", "site-packages", "jupyter_book", "dist", "jupyter-book.cjs"
)

BAD = """  iframe(node3, state) {
    const image6 = node3.children?.[0];
    if (!image6 || image6.placeholder !== true)
      return;
    const { width: nodeWidth, url: nodeSrc, align: align2 } = image6;
    const src = nodeSrc;
    const width = getLatexImageWidth2(nodeWidth);
    state.write(`#image("${src}"`);
    if (!state.data.isInTable) {
      state.write(`, width: ${width}`);
    }
    state.write(")\\n\\n");
  },"""

GOOD = """  iframe(node3, state) {
    const image6 = node3.children?.[0];
    if (!image6 || image6.placeholder !== true)
      return;
    const { width: nodeWidth, url: nodeSrc, align: align2 } = image6;
    const src = nodeSrc;
    const width = getLatexImageWidth2(nodeWidth);
    let dest = node3.src || null;
    if (dest) {
      const marker = "youtube.com/embed/";
      const idx = dest.indexOf(marker);
      if (idx >= 0) {
        const rest = dest.slice(idx + marker.length);
        const qpos = rest.indexOf("?");
        const vid = qpos >= 0 ? rest.slice(0, qpos) : rest;
        const extra = qpos >= 0 ? "&" + rest.slice(qpos + 1) : "";
        dest = dest.slice(0, idx) + "youtube.com/watch?v=" + vid + extra;
      }
      dest = dest.replace(/\\\\/g, "\\\\\\\\").replace(/"/g, '\\\\"');
    }
    if (dest) {
      state.write(`#link("${dest}")[`);
    }
    state.write(`#image("${src}"`);
    if (!state.data.isInTable) {
      state.write(`, width: ${width}`);
    }
    state.write(")");
    if (dest) {
      state.write(`]`);
    }
    state.write("\\n\\n");
  },"""


def main() -> int:
    if not os.path.exists(BUNDLE):
        print(f"bundle not found: {BUNDLE}")
        return 1
    data = open(BUNDLE, encoding="utf-8").read()
    if GOOD in data:
        print("mystmd bundle already patched")
        return 0
    if BAD not in data:
        print("mystmd bundle does not match — refusing to patch (version drift?)")
        return 1
    open(BUNDLE, "w", encoding="utf-8").write(data.replace(BAD, GOOD, 1))
    print("patched mystmd bundle: iframe placeholders now link to their source")
    return 0


if __name__ == "__main__":
    sys.exit(main())
