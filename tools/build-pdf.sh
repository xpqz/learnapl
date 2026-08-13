#!/usr/bin/env bash
# Standalone PDF build for the Learning APL book (Jupyter Book 2 / MyST, Typst).
#
# Produces contents/exports/book.pdf, then rebuilds the site so the PDF is
# bundled as a downloadable asset (the site's download panel references the
# export id "book-pdf").
#
# Order matters:
#   1. execute + HTML  -- notebook execution only happens during an HTML/site
#      pass (the typst export always uses cached outputs), so this must come
#      first; results are cached in _build/execute/.
#   2. typst export    -- renders the PDF from the executed outputs; MyST's
#      exporter mangles a few Unicode chars in prose (→ × …), so we patch the
#      generated .typ files and recompile with the typst CLI (patch-typst.py).
#   3. HTML again      -- bundles the exported PDF into the site.
# Drop `--execute` in step 1 for a quick rebuild from the outputs already
# stored in the notebooks.
#
# Requirements (see build-notes.md):
#   - the project venv (activated here)
#   - `typst` and `imagemagick` on PATH   (brew install typst imagemagick)
#   - the APL387 font (https://dyalog.github.io/APL387/) installed for typst
#     (e.g. ~/Library/Fonts/APL387.ttf) — used for all code and output
#
# Usage: tools/build-pdf.sh
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
root="$(dirname "$here")"

# shellcheck disable=SC1091
. "$root/.venv/bin/activate"

# Patch the bundled MyST exporter so `hide-output` cells keep their outputs in
# the PDF (the stock exporter drops them in the typst path; see the script).
python "$root/tools/patch-mystmd-outputs.py"

# ...and so `<kbd>` keystrokes aren't silently dropped from the PDF (the stock
# typst renderer has no `keyboard` handler; see the script).
python "$root/tools/patch-typst-keyboard.py"

cd "$root/contents"

jupyter book build --execute --html
jupyter book build --typst

# Patch the mangled glyphs in the generated typst and recompile exports/book.pdf.
(cd "$root" && python tools/patch-typst.py)

jupyter book build --html

# Re-apply the local APL syntax highlighting patch to the built theme
# (the HTML builds regenerate the theme bundle). Expects the repo root as CWD.
(cd "$root" && python tools/patch-apl-highlight.py)

echo
echo "PDF: $root/contents/exports/book.pdf"
