# Dyalog APL Kernel Issue Summary

## Problem
The Dyalog APL kernel was not showing up in VS Code's "Select Kernel" dropdown for Jupyter notebooks.

## Root Cause
The VS Code workspace settings file (`.vscode/settings.json`) contained a configuration that explicitly excluded the virtual environment from Jupyter kernels:

```json
"jupyter.kernels.excludePythonEnvironments": [
    "${workspaceFolder}/.venv/bin/python"
]
```

This prevented VS Code from using the virtual environment's Python interpreter to launch kernels, which meant it couldn't find the `dyalog_kernel` module installed in the `.venv`.

## Investigation Steps
1. Confirmed Dyalog APL kernels were installed:
   - `dyalog-kernel` at `/Users/stefan/Library/Jupyter/kernels/dyalog-kernel`
   - `dyalog_apl` at `/Users/stefan/Library/Jupyter/kernels/dyalog_apl`

2. Verified the kernel specs were valid and both had identical configurations

3. Confirmed `dyalog_kernel` module was installed in the virtual environment:
   - Located at `/Users/stefan/work/notebooks/learnapl/.venv/lib/python3.11/site-packages/dyalog_kernel/`

4. Found the issue in VS Code settings that excluded the virtual environment

## Solution
Removed the `jupyter.kernels.excludePythonEnvironments` setting from `.vscode/settings.json`, leaving only:

```json
{
    "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python"
}
```

This allows VS Code to use the virtual environment's Python to launch the Dyalog APL kernel, which can properly import the `dyalog_kernel` module.

## Next Steps
After making this change, VS Code should be reloaded or restarted for the Dyalog APL kernel to appear in the kernel selection dropdown.

## Update (2025-06-13)
After restarting VS Code, the kernel still wasn't showing up. Further investigation revealed:

1. The `dyalog_kernel` module IS installed in the virtual environment
   - Package name: `dyalog-jupyter-kernel` version 2.0.2
   - Location: `/Users/stefan/work/notebooks/learnapl/.venv/lib/python3.11/site-packages/dyalog_kernel/`
   - The module imports successfully when tested

2. Both kernel specs are properly installed:
   - `dyalog-kernel` at `/Users/stefan/Library/Jupyter/kernels/dyalog-kernel` (older)
   - `dyalog_apl` at `/Users/stefan/Library/Jupyter/kernels/dyalog_apl` (newer, preferred)
   - Both reference the same `dyalog_kernel` module

3. Jupyter Lab picks up both kernels without issues, confirming they're properly installed

4. Added `"jupyter.kernels.filter": []` to `.vscode/settings.json` to ensure VS Code doesn't filter out any kernels

The issue appears to be specific to VS Code's kernel discovery mechanism, not with the kernel installation itself.

## Update (2025-06-13) - Clean Reinstall

After further investigation:

1. **Found duplicate kernel installations** causing conflicts:
   - `dyalog-kernel` at `/Users/stefan/Library/Jupyter/kernels/dyalog-kernel`
   - `dyalog_apl` at `/Users/stefan/Library/Jupyter/kernels/dyalog_apl`
   - `kernelspec` at `/Users/stefan/Library/Jupyter/kernels/kernelspec` (identical to dyalog_apl)
   - VS Code was showing warnings about duplicate kernels with the same display name

2. **Cleaned up all kernels** using `jupyter kernelspec uninstall` for all three

3. **Reinstalled using the correct command** from Dyalog documentation:
   ```bash
   python -m 'dyalog_kernel' install
   ```
   This installed a single kernel at `/Users/stefan/Library/Jupyter/kernels/dyalog_apl`

4. **Key observation**: The kernel.json uses `python3` in argv instead of a specific Python path:
   ```json
   {
       "argv": ["python3", "-m", "dyalog_kernel",
                "-f", "{connection_file}"],
       "display_name": "Dyalog APL",
       "language": "apl"
   }
   ```
   This relies on VS Code having the correct Python environment activated when launching the kernel.

5. **VS Code settings** updated to trust the kernel:
   ```json
   {
       "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
       "jupyter.kernels.filter": [],
       "jupyter.kernels.trusted": [
           "/Users/stefan/Library/Jupyter/kernels/dyalog_apl/kernel.json"
       ]
   }
   ```

Next step: Reload VS Code to test if the clean installation resolves the kernel visibility issue.

## Update (2025-06-13) - Current Hypothesis

After reading about Jupyter virtual environment setup, discovered that the virtual environment was missing `ipykernel`. When a kernel spec uses `python3` in its argv (as the Dyalog kernel does), VS Code needs the Python environment to have ipykernel installed to properly launch kernels.

**Actions taken:**
1. Installed `dyalog-jupyter-kernel` in the virtual environment, which also installed `ipykernel` as a dependency:
   ```bash
   source .venv/bin/activate
   pip install dyalog-jupyter-kernel
   ```

2. Reinstalled the Dyalog kernel to ensure proper registration:
   ```bash
   source .venv/bin/activate
   python -m dyalog_kernel install --user
   ```

**To test:** Reload VS Code to see if the Dyalog APL kernel now appears in the kernel picker.