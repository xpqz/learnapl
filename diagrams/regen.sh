#!/usr/bin/env bash
#
# Regenerate the TikZ diagram SVGs used by the book.
#
# Each diagrams/<name>.tex is a plain LaTeX document holding one tikzpicture.
# For every source this script runs:
#     pdflatex           -> PDF (one page, on a full letter page)
#     ghostscript bbox   -> the picture's ink bounding box
#     ghostscript crop   -> re-emit the PDF with the MediaBox set to that box
#                           plus an 8pt border (this replaces the `standalone`
#                           document class, which BasicTeX doesn't ship)
#     pdftocairo -svg    -> contents/IMG/<name>.svg
#
# Requirements (all present on the authoring machine):
#   - a TeX with pdflatex + pgf/tikz  (BasicTeX: brew install --cask basictex;
#     then `sudo tlmgr install pgf`).  Lives under /Library/TeX/texbin.
#   - ghostscript   (brew install ghostscript)   -> gs
#   - poppler       (brew install poppler)        -> pdftocairo
#
# Usage:  diagrams/regen.sh            # rebuild every diagram
#         diagrams/regen.sh atop over  # rebuild only the named ones
#
set -euo pipefail

BORDER=8   # pt of whitespace kept around each figure

here="$(cd "$(dirname "$0")" && pwd)"
root="$(cd "$here/.." && pwd)"
outdir="$root/contents/IMG"
export PATH="/Library/TeX/texbin:$PATH"

for bin in pdflatex gs pdftocairo; do
  command -v "$bin" >/dev/null 2>&1 || { echo "error: '$bin' not found on PATH" >&2; exit 1; }
done
mkdir -p "$outdir"

# Which sources to build: named args, or all of diagrams/*.tex.
if [ "$#" -gt 0 ]; then
  sources=(); for n in "$@"; do sources+=("$here/$n.tex"); done
else
  sources=("$here"/*.tex)
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

for tex in "${sources[@]}"; do
  name="$(basename "$tex" .tex)"
  [ -f "$tex" ] || { echo "error: no such source: $tex" >&2; exit 1; }

  pdflatex -interaction=nonstopmode -halt-on-error -output-directory "$tmp" "$tex" >/dev/null

  bbox="$(gs -q -dBATCH -dNOPAUSE -sDEVICE=bbox "$tmp/$name.pdf" 2>&1 \
          | sed -n 's/^%%HiResBoundingBox://p')"

  read -r W H OX OY < <(python3 - "$BORDER" $bbox <<'PY'
import sys, math
p = float(sys.argv[1])
x0, y0, x1, y1 = map(float, sys.argv[2:6])
print(math.ceil(x1 - x0 + 2*p), math.ceil(y1 - y0 + 2*p),
      round(p - x0, 3), round(p - y0, 3))
PY
)

  gs -o "$tmp/$name-crop.pdf" -sDEVICE=pdfwrite -dBATCH -dNOPAUSE -dFIXEDMEDIA \
     -dDEVICEWIDTHPOINTS="$W" -dDEVICEHEIGHTPOINTS="$H" \
     -c "<</PageOffset [$OX $OY]>> setpagedevice" -f "$tmp/$name.pdf" >/dev/null

  pdftocairo -svg "$tmp/$name-crop.pdf" "$outdir/$name.svg"
  echo "regenerated contents/IMG/$name.svg (${W}x${H}pt)"
done
