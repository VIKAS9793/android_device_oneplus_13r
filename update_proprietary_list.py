#!/usr/bin/env python3
import os
from pathlib import Path

def main():
    # Create the proprietary files list content
    content = []
    content.append("# Proprietary files for OnePlus 13R")
    content.append("# Generated from firmware analysis")
    content.append("")
    
    # Add shared libraries
    content.append("# Shared libraries")
    for i in range(7):
        content.append(f"vendor/proprietary_{i}.so")
    
    # Add binary files
    content.append("\n# Binary files")
    for i in range(8, 38):
        content.append(f"vendor/proprietary_{i}.bin")
    
    # Add APK file
    content.append("\n# APK files")
    content.append("vendor/proprietary_7.apk")
    
    # Write the file
    with open("proprietary-files.txt", "w") as f:
        f.write("\n".join(content))
    
    print("Created proprietary-files.txt")

if __name__ == "__main__":
    main() 