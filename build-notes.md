# Build

The book is a **Jupyter Book 2 (MyST)** project. Config lives in `contents/myst.yml`
(the old JB1 `_config.yml`/`_toc.yml` are kept as `*.jb1bak` for reference). Notebooks
execute against a **Dyalog APL** kernel over RIDE.

## Environment (one-time)

```sh
# Python env (uv), Python 3.12
uv venv --python 3.12 .venv
uv pip install --python .venv/bin/python -r contents/requirements.txt

# Dyalog Jupyter kernel — from source (editable), then register the kernelspec
git clone https://github.com/Dyalog/dyalog-jupyter-kernel ~/work/dyalog-jupyter-kernel
uv pip install --python .venv/bin/python -e ~/work/dyalog-jupyter-kernel
.venv/bin/python -m dyalog_kernel install --user
```

Provenance / prerequisites:
- Kernel: `github.com/Dyalog/dyalog-jupyter-kernel` @ `16d0b89` (master, v2.0.2).
- **Node.js >= 20** is required by the MyST engine (v23.8.0 used here; auto-provisioned
  via `nodeenv` if absent). Match an LTS in CI.
- The installed kernelspec `~/Library/Jupyter/kernels/dyalog_apl/kernel.json` has its
  `argv[0]` pointed at the venv's python (`…/.venv/bin/python`) so it launches under the
  right interpreter regardless of shell activation.

Interpreter selection (macOS): the kernel picks `mapl` on PATH, then `dyalog` on PATH,
then scans `/Applications` for `Dyalog-*.app`. Here `dyalog` (homebrew, 21.0) wins, so
notebooks run on **Dyalog 21.0** (newest). To force a specific version, put that version's
`mapl` first on PATH.

## Build

Run with the venv activated so the MyST engine can find `jupyter-server` and launch the
kernel (otherwise execution silently no-ops with "Could not load Jupyter session manager"):

```sh
. .venv/bin/activate
cd contents
jupyter book build --html --execute        # HTML site into contents/_build/html
# jupyter book start --execute             # live preview server (http://localhost:3000)
```

`--execute` runs the notebooks (cached in `_build/execute/`); omit it to build from the
outputs already in the `.ipynb` files.

Note: notebook execution is cached and keyed on the **code cells** of each notebook —
edits that only touch markdown cells (prose, admonitions, images) reuse the cache and
show "Adding cached notebook outputs". `jupyter book build -d` (debug) forces execution.

## PDF export (standalone tool)

`tools/build-pdf.sh` is the one-shot recipe: execute → PDF → HTML → highlight patch.
It produces `contents/exports/book.pdf` (git-ignored) and bundles it into the site, where
every page's download panel links it (config: `project.exports` id `book-pdf` + the
`project.downloads` entry in `myst.yml`).

```sh
tools/build-pdf.sh
```

System prerequisites (on top of the venv/Node ones above):

```sh
brew install typst imagemagick
```

Plus the **APL387 font** (https://dyalog.github.io/APL387/APL387.ttf), installed where
typst finds it (e.g. `~/Library/Fonts/`); check with `typst fonts | grep -i apl`. It is
used for all code and output in the PDF, mirroring the site (`custom.css` forces APL387 on
code and output). Verify it's embedded: `pdffonts contents/exports/book.pdf | grep -i apl`.

- The export is **Typst**, not LaTeX: `format: typst` with a **local fork** of the
  `plain_typst_book` template at `contents/_templates/plain_typst_book` (git-tracked),
  built via `jupyter book build --typst`. The `--pdf` flag routes to LaTeX and cannot
  fetch typst templates; the machine's TeX install lacks `latexmk`, and pdflatex would
  choke on APL glyphs anyway — don't go down that path.
- The template fork (`style.typ`) does the PDF-specific layout: all raw/code and output
  in **APL387** (`show raw: set text(font: "APL387")`); code cells and their output as
  blue/green **panels** like the site; tighter output line pitch so box-drawn tables
  render without gaps; **block quotes** as italic with a gray left rule; and a **footer**
  (book title left, page number right) — enabled by `show_pagenumber: true`. It also
  softens page breaks (`pagebreak(weak: true)`) so chapters starting exactly at a page
  bottom don't leave blank pages.
- **Vendored wrap-it:** typst 0.15.1 has no native float/text-wrapping, so the
  float-right composition diagrams (atop, fork, over, behind, cos — `fig-float-right`
  on the site) are placed with the vendored `wrap-it.typ` (Unlicense, kept in the
  template dir and listed in `template.yml`'s `files:` so fresh exports copy it).
- **Bundled-exporter patches** (`tools/patch-mystmd-outputs.py`,
  `tools/patch-typst-keyboard.py`, `tools/patch-typst-links.py`,
  `tools/patch-typst-iframe.py`) rewrite the installed `jupyter_book/dist/jupyter-book.cjs`
  bundle before the typst export runs — there's no config knob for these, so
  `build-pdf.sh` patches the exporter's own JS in place. Idempotent (each checks whether
  it's already applied) and each refuses rather than guessing if the bundle no longer
  matches (version drift). They fix, respectively: `hide-output`-tagged cells losing
  their outputs in the typst path, `<kbd>` keystrokes vanishing silently, link
  *destinations* getting corrupted (the exporter's `linkHandler` ran hrefs through the
  same markup-escaper used for displayed text, so any URL containing `_ * # $ &` etc. —
  every Wikipedia and aplwiki.com link, since MediaWiki paths use underscores for spaces —
  came out with a stray backslash baked into the actual link target, breaking it; fixed
  by only escaping the destination for Typst string-literal syntax, not markup), and
  `:::{iframe}` embeds (the ride.ipynb YouTube walkthroughs) rendering their
  `:placeholder:` still image as a bare, unlinked `#image(...)` — the handler read the
  placeholder's own path but never `node3.src` (the actual video URL), so the PDF reader
  got a static frame with no way to reach the video; fixed by wrapping the placeholder in
  a link to `node3.src` — rewritten from the iframe's `/embed/<id>` form (needs a
  parent-page/JS context to play, so it doesn't work opened on its own) to the standard
  `/watch?v=<id>` URL used everywhere else in the book.
- **`tools/patch-typst.py`** post-processes the generated `.typ` files and recompiles
  `exports/book.pdf` with the `typst` CLI (the build script runs it right after the
  export). Its jobs, in order:
  1. **Glyph unmangling** — the exporter rewrites a handful of Unicode characters in
     prose and html-derived output text into symbol names (`→`→`arrow.r`, `←`→`arrow.l`,
     `×`→`$times$`, `≠`→`$eq.not$`, `∼`→`$tilde$`, `∞`→`$infty$`); inside raw/code
     blocks the characters survive intact. Reversed here.
  2. **Output panels** — retags bare fenced blocks following ```apl input cells as
     ```output so the template's panel rules can colour them green, like the site.
  3. **Weak pagebreaks** — `#pagebreak()` → `#pagebreak(weak: true)`.
  4. **Float-right diagrams** — rewrites the diagram `#image(...)` calls as
     `wrap-content` blocks so the following paragraph wraps beside the image, like the
     site's CSS.
  5. **Illustration sizing** — clamps every markdown image to
     `min(90%, 60%, native pixel width)`, so small diagrams aren't blown up and
     pixelated (the exporter emits everything at `width: 90%`). Widths are read from
     the PNG/JPEG/GIF headers directly.
  6. **Glued blocks** — the exporter sometimes emits a heading/image directly after
     another element's closing `]` with no newline; typst only recognises headings at
     line starts, so a blank line is inserted before the following block.
  7. **Image centering** — a bare markdown image renders as a plain `#image(...)`
     call, which typst left-aligns like any other block; wrap those in
     `#align(center, ...)`. Float-right diagrams (item 4) no longer look like a bare
     `#image(...)` line by this point, and figure-captioned images (e.g. the ride.ipynb
     video placeholders) are already centered by typst's own figure default, so neither
     is touched.
- Template edits (`style.typ`, `wrap-it.typ`) take effect on the next export — the
  exporter copies the template dir's `files:` list into the temp build dir; the patch
  script then works on the newest `_build/temp/myst*` dir.
- The export uses the **project TOC order**, but a project-level export skips the landing
  page — the export therefore lists `articles:` explicitly (intro.ipynb first). Keep that
  list in sync with `toc` when adding/removing chapters.
- **Kernel outputs must be `<pre class="language-APL">`-wrapped html, not
  `<span style="white-space:pre; font-family: monospace">`.** The span form is emitted by
  the export as a mangled single-line paragraph instead of a raw block (see above), while
  the pre form becomes a proper raw block. All stored outputs were normalized to the pre
  form — keep it that way (the site CSS styles both identically).
- The export pipeline is stricter than the site renderer. Content patterns that silently
  drop content from the PDF (already purged from the book, keep it that way):
  - kind-less `:::{admonition} Title` blocks — use `:::{note} Title` (with
    `:class: resources` if you want the site's resources-panel styling).
  - a `(from [Link](url))` paragraph after a blockquote — use a `\--[Link](url)`
    attribution line instead.
  - raw `<kbd>` HTML — use inline code `` `key` ``.
  - animated webp/gif images — typst (via `dwebp`) can't decode them; export a static
    frame instead (imagemagick is installed for this).

## APL syntax highlighting (local theme patch)

The book-theme highlights code with `react-syntax-highlighter` (highlight.js), which has
**no APL grammar** — so APL code cells would render as unhighlighted `language-text` (JB1
had colour via Sphinx/Pygments, which ships an APL lexer). There is no theme setting to
add a language, so `tools/patch-apl-highlight.py` applies a small local patch to the
built theme bundle: it drops a hand-written hljs APL grammar into each `_shared` asset
dir and registers it in the theme's async language map. The theme's own hljs stylesheet
then colours the tokens (comments, strings, numbers, `]`/`)` system commands, `⎕`/`⍞`
names).

The patched files live under `contents/_build` (git-ignored, regenerated), so the script
is idempotent and must be re-run whenever the bundle is regenerated:

```sh
jupyter book build --html                    # (re)creates _build/html
python tools/patch-apl-highlight.py          # patch _build/html + the cached theme
# jupyter book start                         # dev server; run the patch first if the
                                             # theme cache was cleared/re-fetched
```

To adjust the token palette, override the `.hljs-comment` / `.hljs-string` /
`.hljs-number` / `.hljs-meta` / `.hljs-built_in` colours in `contents/custom.css`.

## Publish (GitHub Pages)

The build stays local (it needs the Dyalog kernel, typst and the APL387 font); nothing is
built in CI. One command builds and publishes:

```sh
tools/publish.sh             # build, show what changed, ask, push
tools/publish.sh --dry-run   # build and prepare the commit, but don't push
```

It runs `tools/build-pdf.sh` with `BASE_URL=/learnapl` (the site is served from a
subdirectory; a plain local build would publish broken links), then adds the contents of
`contents/_build/html` as one new commit on the `gh-pages` branch, which GitHub Pages
serves (Settings → Pages → Source = "Deploy from a branch", `gh-pages` / root). Merging
to `main` does not publish anything.

The script also writes redirect stubs for the old (Jupyter Book 1) edition's
`<chapter>.html` addresses, and a `404.html`.

**Known cost, deliberately not fixed:** every publish adds a commit to `gh-pages`, so
each one leaves another ~20 MB PDF (its content hash changes on every build) plus the
changed site assets in that branch's history for good. Publishes are rare, so this is
accepted for now. If the repo size becomes a nuisance, change `publish.sh` to push a
single parentless commit with `--force` (start the temp repo with `git init` instead of
cloning `gh-pages`), so the branch only ever holds the current site. That discards the
existing `gh-pages` history, and rolling the live site back then means rebuilding from an
older `main` commit.

After a publish, `contents/_build/html` has the `/learnapl` prefix baked in; rebuild
without `BASE_URL` (or use `jupyter book start`) for local viewing.
