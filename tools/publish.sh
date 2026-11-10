#!/usr/bin/env bash
# Push-button publish of the Learning APL book to GitHub Pages.
#
# Builds the site + PDF locally (tools/build-pdf.sh, so the notebooks execute
# against the local Dyalog kernel) with the Pages base URL baked in, then adds
# the result as one new commit on the `gh-pages` branch, which GitHub Pages
# serves at https://xpqz.github.io/learnapl. Nothing is built in CI.
#
# Usage: tools/publish.sh [--dry-run] [--yes]
#   --dry-run   build and prepare the gh-pages commit, but don't push it
#   --yes       don't ask for confirmation before pushing
set -euo pipefail

remote=origin
branch=gh-pages
base_url=/learnapl

dry_run=0
yes=0
for arg in "$@"; do
    case "$arg" in
        --dry-run) dry_run=1 ;;
        --yes) yes=1 ;;
        *) echo "usage: $0 [--dry-run] [--yes]" >&2; exit 2 ;;
    esac
done

here="$(cd "$(dirname "$0")" && pwd)"
root="$(dirname "$here")"
html="$root/contents/_build/html"
cd "$root"

if [ -n "$(git status --porcelain --untracked-files=no)" ]; then
    echo "warning: uncommitted changes — the published site won't match any commit" >&2
fi
src="$(git rev-parse --short HEAD) ($(git rev-parse --abbrev-ref HEAD))"

# The site is served from a subdirectory, so asset and page links need the
# prefix; a plain local build (no BASE_URL) would publish a broken site.
BASE_URL="$base_url" "$here/build-pdf.sh"

[ -f "$html/index.html" ] || { echo "error: no $html/index.html" >&2; exit 1; }
grep -q "$base_url/" "$html/index.html" \
    || { echo "error: build does not reference $base_url/ — BASE_URL not applied?" >&2; exit 1; }

# Exactly one PDF should be bundled, and it should be the one just exported.
pdfs=("$html"/build/book-*.pdf)
[ "${#pdfs[@]}" = 1 ] && cmp -s "${pdfs[0]}" "$root/contents/exports/book.pdf" \
    || { echo "error: expected exactly one bundled PDF matching exports/book.pdf, found: ${pdfs[*]}" >&2; exit 1; }
grep -q "$(basename "${pdfs[0]}")" "$html/index.html" \
    || { echo "error: site does not link the bundled PDF" >&2; exit 1; }

# Fresh shallow checkout of the published branch; swap its contents wholesale.
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
url="$(git remote get-url "$remote")"
git clone --quiet --depth 1 --branch "$branch" "$url" "$work"
git -C "$work" rm -r --quiet --ignore-unmatch .
cp -R "$html/." "$work/"
touch "$work/.nojekyll"          # serve _-prefixed dirs as-is

# The previous (Jupyter Book 1) edition served pages as <chapter>.html, with
# intro.html as the landing page that index.html redirected to. Leave redirect
# stubs at those addresses so bookmarks, search results, inbound links and
# browser-cached redirects reach the new <chapter>/ pages instead of a 404.
redirect() {  # redirect <stub file> <relative target>
    cat > "$work/$1" <<EOF
<!doctype html>
<meta charset="utf-8">
<title>Learning APL</title>
<link rel="canonical" href="https://xpqz.github.io$base_url/${2#./}">
<meta http-equiv="refresh" content="0; url=$2">
<script>location.replace("$2" + location.hash)</script>
<p>This page has moved <a href="$2">here</a>.</p>
EOF
}
for dir in "$work"/*/; do
    page="$(basename "$dir")"
    [ -f "$dir/index.html" ] && redirect "$page.html" "$page/"
done
# Landing page, and pages of the old edition that no longer exist.
for gone in intro cookbook1 manip genindex search; do
    [ -e "$work/$gone.html" ] || redirect "$gone.html" "./"
done
cat > "$work/404.html" <<EOF
<!doctype html>
<meta charset="utf-8">
<title>Page not found - Learning APL</title>
<p>There is no page at this address. Go to the
<a href="$base_url/">start of Learning APL</a>.</p>
EOF
git -C "$work" add --all

if git -C "$work" diff --cached --quiet; then
    echo "Nothing to publish: $branch already matches this build."
    exit 0
fi
git -C "$work" commit --quiet -m "Publish $src"
echo
git -C "$work" show --stat --format='%h %s' HEAD | tail -n 1

if [ "$dry_run" = 1 ]; then
    echo "Dry run: not pushing."
    exit 0
fi
if [ "$yes" != 1 ]; then
    read -r -p "Publish $src to https://xpqz.github.io$base_url ? [y/N] " reply
    [ "$reply" = y ] || [ "$reply" = Y ] || { echo "Aborted."; exit 1; }
fi
git -C "$work" push --quiet "$remote" "$branch"
echo "Published. Live in a minute or so: https://xpqz.github.io$base_url"
