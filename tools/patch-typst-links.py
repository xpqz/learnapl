#!/usr/bin/env python3
"""Patch the bundled MyST typst exporter so link *destinations* aren't mangled.

`linkHandler` writes a link as `#link("<dest>")[<label>]`. For `<dest>` it runs
the href through `hrefToLatexText2`, which markup-escapes characters that are
special in Typst markup mode (underscore, asterisk, hash, dollar, ampersand,
backtick and friends each get a backslash prefixed) — the right thing for
text that will be *displayed*, wrong for a destination string, which is a
plain Typst string literal where those characters have no special meaning.
The result: any link whose URL contains one of those characters gets a stray
backslash baked into the actual hyperlink target, breaking it. For example,
a link to the Wikipedia-style path `wiki/Reverse_Compose` comes out as
`wiki/Reverse` followed by a backslash and an underscore and `Compose` --
a URL that 404s.

This is systemic: every Wikipedia link (`/wiki/Some_Title`) and any other URL
containing one of those markup-special characters comes out broken in the
PDF, silently -- the export still exits 0. Fixed at the source by escaping
the destination only for Typst string-literal syntax (backslash and double
quote), not markup.

There is no config option for this, so we patch the exporter bundle in the
venv, alongside `patch-mystmd-outputs.py` and `patch-typst-keyboard.py`.

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

BAD = """var linkHandler = (node3, state) => {
  const href = node3.url;
  state.write('#link("');
  state.write(hrefToLatexText2(href));
  state.write('")');"""

GOOD = """var linkHandler = (node3, state) => {
  const href = node3.url;
  state.write('#link("');
  state.write(href.replace(/\\\\/g, "\\\\\\\\").replace(/"/g, '\\\\"'));
  state.write('")');"""


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
    print("patched mystmd bundle: link destinations no longer markup-escaped")
    return 0


if __name__ == "__main__":
    sys.exit(main())
