#!/usr/bin/env python3
"""Patch the bundled MyST typst exporter so `<kbd>` keystrokes survive into PDFs.

MyST parses `<kbd>ctrl</kbd>` into a `keyboard` node. The HTML theme renders it
as a key-cap, but the typst renderer has no handler for it, so it logs

    ⛔️ Unhandled Typst conversion for node of "keyboard"

and emits *nothing* — the key names silently vanish from the PDF while the
literal hyphens between them remain:

    "you use <kbd>ctrl</kbd>-<kbd>shift</kbd>-<kbd>backspace</kbd> for up"
      -> "you use – for up"

That guts the Ride chapter in print (22 of the book's 33 `<kbd>` uses live
there), and the export still exits 0, so it ships unnoticed. This cannot be
fixed in `patch-typst.py`: the content is already gone by the time the `.typ`
files are written, so it has to be fixed in the renderer.

There is no config option for this, so we patch the exporter bundle in the
venv, alongside `patch-mystmd-outputs.py`. The handler wraps the children in a
`#box` with a hairline stroke so keystrokes read as key-caps in print, matching
the HTML.

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

# The `keyboard` handler is inserted between these two existing inline handlers.
ANCHOR = """  abbreviation(node3, state) {
    state.renderChildren(node3);
  },
  inlineExpression(node3, state) {"""

KEYCAP = (
    "#box(stroke: 0.5pt + luma(60%), inset: (x: 3pt, y: 1pt), "
    "outset: (y: 2pt), radius: 2pt)["
)

PATCHED = """  abbreviation(node3, state) {
    state.renderChildren(node3);
  },
  keyboard(node3, state) {
    state.write("%s");
    state.renderChildren(node3);
    state.write("]");
  },
  inlineExpression(node3, state) {""" % KEYCAP


def main() -> int:
    if not os.path.exists(BUNDLE):
        print(f"bundle not found: {BUNDLE}")
        return 1
    data = open(BUNDLE, encoding="utf-8").read()
    if "keyboard(node3, state) {" in data:
        print("mystmd typst renderer already handles keyboard nodes")
        return 0
    if ANCHOR not in data:
        print("mystmd typst renderer does not match — refusing to patch (version drift?)")
        return 1
    open(BUNDLE, "w", encoding="utf-8").write(data.replace(ANCHOR, PATCHED, 1))
    print("patched mystmd bundle: <kbd> keystrokes now render as key-caps in PDF")
    return 0


if __name__ == "__main__":
    sys.exit(main())
