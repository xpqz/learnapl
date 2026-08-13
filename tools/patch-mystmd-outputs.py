#!/usr/bin/env python3
"""Patch the bundled MyST md exporter so PDFs keep `hide-output` cell outputs.

Jupyter cells tagged ``hide-output`` are collapsed behind a toggle in the HTML
build, but the MyST typst export treats the tag as "remove the outputs": the
`reduceOutputs` step in the bundled exporter deletes the outputs of any cell
whose outputs node has `visibility === "hide"`, so the PDF silently loses
those cells entirely (e.g. the `⎕IO ← 0` setup cells and the key/rank drills).

There is no config option for this, so we patch the exporter bundle in the
venv. The patch is idempotent and only touches one branch: `hide` no longer
deletes outputs, while `remove` (the `remove-output` tag) still does.

Run from the repository root. Safe to run on every build — if the bundle is
already patched (or a future version no longer matches), it exits 0.
"""

import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BUNDLE = os.path.join(
    ROOT, ".venv", "lib", "python3.12", "site-packages", "jupyter_book", "dist", "jupyter-book.cjs"
)

BAD = '''    if (outputsNode.visibility === "remove" || outputsNode.visibility === "hide") {
      outputsNode.type = "__delete__";
      return;
    }'''
GOOD = '''    if (outputsNode.visibility === "remove") {
      outputsNode.type = "__delete__";
      return;
    }'''


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
    print("patched mystmd bundle: `hide` visibility no longer drops cell outputs in PDF")
    return 0


if __name__ == "__main__":
    sys.exit(main())
