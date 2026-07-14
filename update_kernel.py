#!/usr/bin/env python3
"""Update kernel name in all Jupyter notebooks from dyalog-kernel to dyalog_apl"""

import json
import glob
import os

def update_notebook_kernel(filepath):
    """Update the kernel name in a single notebook"""
    with open(filepath, 'r') as f:
        notebook = json.load(f)
    
    # Check if this notebook uses the old kernel
    if ('metadata' in notebook and 
        'kernelspec' in notebook['metadata'] and
        notebook['metadata']['kernelspec'].get('name') == 'dyalog-kernel'):
        
        # Update the kernel name
        notebook['metadata']['kernelspec']['name'] = 'dyalog_apl'
        
        # Write back the updated notebook
        with open(filepath, 'w') as f:
            json.dump(notebook, f, indent=1)
        
        print(f"Updated: {filepath}")
        return True
    
    return False

def main():
    # Find all notebook files
    notebook_files = glob.glob('contents/**/*.ipynb', recursive=True)
    notebook_files.extend(glob.glob('*.ipynb'))
    
    updated_count = 0
    
    for notebook_file in notebook_files:
        if update_notebook_kernel(notebook_file):
            updated_count += 1
    
    print(f"\nTotal notebooks updated: {updated_count}")
    print(f"Total notebooks checked: {len(notebook_files)}")

if __name__ == "__main__":
    main()