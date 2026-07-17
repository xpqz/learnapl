#!/usr/bin/env python3
"""Local patch: teach the MyST book-theme to syntax-highlight APL.

Why this exists
---------------
The book-theme highlights code with `react-syntax-highlighter` (highlight.js).
highlight.js has **no APL grammar at all**, so APL code cells render as plain
`language-text` (the JB1 edition had colour via Sphinx/Pygments, which does ship
an APL lexer). There is no theme config to add a language, and the theme is
shipped pre-built, so the fix is a small local patch to the built bundle:

  1. drop a hand-written hljs APL grammar chunk (`apl-hljs.js`) into each
     `_shared` asset dir, and
  2. register it in react-syntax-highlighter's async language map (the chunk that
     defines `abnf:K("abnf", ...)` etc., which omits `apl`).

The theme's own hljs stylesheet then colours the resulting tokens (comments,
strings, numbers, `]`/`)` system commands, `⎕`/`⍞` names).

The patched files live under `contents/_build`, which is git-ignored and
regenerated, so this script is idempotent and must be re-run whenever the theme
is re-fetched or the site is rebuilt:

    python tools/patch-apl-highlight.py            # patches contents/_build
    python tools/patch-apl-highlight.py <dir>      # patches a specific tree

Run it after `jupyter book build` (to patch `_build/html`) and before/at
`jupyter book start` (to patch the cached theme the dev server serves).
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

# Hand-written highlight.js APL grammar. Its default export is the language
# factory `fn(hljs) -> definition`, matching every other language chunk the
# theme ships (e.g. ada-*.js). highlight.js has no APL grammar upstream, so this
# is authored here; it covers the tokens the JB1/Pygments edition coloured.
GRAMMAR = r"""export default function(hljs){
  var NAME = /[A-Za-z_∆⍙][A-Za-z0-9_∆⍙]*/;
  var PRIMITIVE = /[-+×÷*⍟⌹○!?⌈⌊⊥⊤⊣⊢=≠≤<>≥≡≢∨∧⍲⍱↑↓⊂⊃⊆⌷⍋⍒⍳⍸∊⍷∪∩~,⍪⍴⌽⊖⍉→←¨⍨⍣⍠⍤⍥∘.⌸⌺⍢⌶⋄@|⍎⍕\/\\⌿⍀{}()\[\];]/;
  return {
    name: "APL",
    case_insensitive: false,
    contains: [
      hljs.COMMENT(/⍝/, /$/),
      { className: "string", begin: /'/, end: /'/, contains: [{ begin: /''/ }] },
      { className: "meta", begin: /^\s*[\]\)]/, end: /$/, contains: [hljs.COMMENT(/⍝/, /$/)] },
      { className: "built_in", begin: /[⎕⍞][A-Za-z]*/ },
      { className: "variable", begin: /[⍺⍵⍶⍹∇]/ },
      { className: "number", begin: /¯?(?:\d+\.?\d*|\.\d+)(?:[eE]¯?\d+)?(?:[jJ]¯?(?:\d+\.?\d*|\.\d+))?/ },
      { className: "title", begin: NAME },
      { className: "keyword", begin: PRIMITIVE }
    ]
  };
}
"""

GRAMMAR_FILENAME = "apl-hljs.js"

# The map chunk registers every language as `<lang>:K("<lang>", function(){ return
# import("<prefix>/<lang>-<hash>.js") })`. We anchor on the `abnf` entry (always
# present, alphabetically first) to (a) detect the asset-path prefix used by this
# copy and (b) inject an `apl` entry right after it.
ANCHOR_RE = re.compile(
    r'abnf:K\("abnf",function\(\)\{return import\("(?P<prefix>[^"]*/)abnf-[^"]+"\)\}\)'
)


def find_map_chunks(root: Path) -> list[Path]:
    return [p for p in root.rglob("*.js") if 'abnf:K("abnf"' in _safe_read(p)]


def _safe_read(p: Path) -> str:
    try:
        return p.read_text(encoding="utf-8")
    except (UnicodeDecodeError, OSError):
        return ""


def patch_chunk(chunk: Path) -> str:
    text = chunk.read_text(encoding="utf-8")
    m = ANCHOR_RE.search(text)
    if not m:
        return "skip (no anchor)"
    prefix = m.group("prefix")

    # 1. write the grammar chunk next to the other language chunks
    (chunk.parent / GRAMMAR_FILENAME).write_text(GRAMMAR, encoding="utf-8")

    # 2. register apl in the async language map (idempotent)
    if 'apl:K("apl"' in text:
        return f"grammar ok, map already patched (prefix {prefix})"
    entry = (
        f',apl:K("apl",function(){{return import("{prefix}{GRAMMAR_FILENAME}")}})'
    )
    text = text[: m.end()] + entry + text[m.end() :]
    chunk.write_text(text, encoding="utf-8")
    return f"patched (prefix {prefix})"


def main(argv: list[str]) -> int:
    root = Path(argv[1]) if len(argv) > 1 else Path("contents/_build")
    if not root.exists():
        print(f"nothing to patch: {root} does not exist", file=sys.stderr)
        return 0  # not an error: build may not have run yet
    chunks = find_map_chunks(root)
    if not chunks:
        print(f"no react-syntax-highlighter language map found under {root}")
        return 0
    for chunk in chunks:
        print(f"{chunk}: {patch_chunk(chunk)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
