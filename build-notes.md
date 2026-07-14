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

## Publish (GitHub Pages)

JB2 publishes via a GitHub Action, not `ghp-import`. Scaffold it once with
`jupyter book init --gh-pages` (sets `BASE_URL=/learnapl`), then Settings → Pages →
Source = GitHub Actions. CI must also install the Dyalog kernel and pass `--execute`, or
commit pre-executed outputs.
