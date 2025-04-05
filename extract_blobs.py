#!/usr/bin/env python3
import os
import shutil
import json
from pathlib import Path

# Define paths
DUMP_DIR = "extracted/mounted"
OUTPUT_DIR = "vendor/oneplus/13r/proprietary"
PROPRIETARY_FILES = "extracted/proprietary-files.txt"

def create_directory_structure():
    """Create the necessary directory structure for vendor blobs"""
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    for root, dirs, _ in os.walk(DUMP_DIR):
        for dir_name in dirs:
            rel_path = os.path.relpath(os.path.join(root, dir_name), DUMP_DIR)
            os.makedirs(os.path.join(OUTPUT_DIR, rel_path), exist_ok=True)

def extract_blobs():
    """Extract blobs from the dump and organize them"""
    # Read proprietary files list
    with open(PROPRIETARY_FILES, 'r') as f:
        files = [line.strip() for line in f if line.strip() and not line.startswith('#')]

    # Create directories and copy files
    for file_path in files:
        src_path = os.path.join(DUMP_DIR, file_path)
        dst_path = os.path.join(OUTPUT_DIR, file_path)
        
        if os.path.exists(src_path):
            os.makedirs(os.path.dirname(dst_path), exist_ok=True)
            shutil.copy2(src_path, dst_path)
            print(f"Copied: {file_path}")
        else:
            print(f"Warning: {file_path} not found in dump")

def update_proprietary_files():
    """Update proprietary-files.txt with correct paths"""
    files = []
    
    # Walk through the dump directory
    for root, _, filenames in os.walk(DUMP_DIR):
        for filename in filenames:
            if filename.endswith(('.so', '.bin', '.apk')):
                rel_path = os.path.relpath(os.path.join(root, filename), DUMP_DIR)
                files.append(rel_path)

    # Write updated proprietary-files.txt
    with open(PROPRIETARY_FILES, 'w') as f:
        f.write("# Audio\n")
        f.write("\n".join(f for f in files if 'audio' in f.lower()))
        f.write("\n\n# Bluetooth\n")
        f.write("\n".join(f for f in files if 'bluetooth' in f.lower()))
        f.write("\n\n# Camera\n")
        f.write("\n".join(f for f in files if 'camera' in f.lower()))
        f.write("\n\n# Display\n")
        f.write("\n".join(f for f in files if 'display' in f.lower() or 'graphics' in f.lower()))
        f.write("\n\n# Firmware\n")
        f.write("\n".join(f for f in files if 'firmware' in f.lower()))
        f.write("\n\n# Other\n")
        f.write("\n".join(f for f in files if not any(x in f.lower() for x in ['audio', 'bluetooth', 'camera', 'display', 'graphics', 'firmware'])))

def main():
    print("Creating directory structure...")
    create_directory_structure()
    
    print("Extracting blobs...")
    extract_blobs()
    
    print("Updating proprietary-files.txt...")
    update_proprietary_files()
    
    print("Done!")

if __name__ == "__main__":
    main() 