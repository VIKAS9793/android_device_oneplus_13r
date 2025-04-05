#!/usr/bin/env python3
import os
import json
from pathlib import Path

def update_proprietary_files():
    # Read the proprietary files list
    with open("extracted/proprietary-files.txt", "r") as f:
        proprietary_files = [line.strip() for line in f if line.strip()]
    
    # Read the analysis file
    with open("extracted/proprietary_analysis.json", "r") as f:
        analysis = json.load(f)
    
    # Create a mapping of file types
    file_types = {}
    for info in analysis:
        name = os.path.basename(info["name"])
        file_types[name] = info["type"]
    
    # Create the proprietary-files.txt content
    content = []
    content.append("# Proprietary files for OnePlus 13R")
    content.append("# Generated from firmware analysis")
    content.append("")
    
    # Add files by type
    content.append("# Shared libraries")
    for file in proprietary_files:
        name = os.path.basename(file)
        if name.endswith(".so") and name in file_types:
            content.append(file)
    
    content.append("\n# Binary files")
    for file in proprietary_files:
        name = os.path.basename(file)
        if name.endswith(".bin") and name in file_types:
            content.append(file)
    
    content.append("\n# APK files")
    for file in proprietary_files:
        name = os.path.basename(file)
        if name.endswith(".apk") and name in file_types:
            content.append(file)
    
    # Write the updated proprietary-files.txt
    with open("device/oneplus/13r/proprietary-files.txt", "w") as f:
        f.write("\n".join(content))
    
    print("Updated proprietary-files.txt")

def update_device_config():
    # Read the device config
    with open("extracted/config/device_config.json", "r") as f:
        config = json.load(f)
    
    # Create the device.mk content
    content = []
    content.append("# OnePlus 13R device configuration")
    content.append("# Generated from firmware analysis")
    content.append("")
    
    # Add device properties
    content.append("PRODUCT_BRAND := OnePlus")
    content.append("PRODUCT_DEVICE := 13r")
    content.append("PRODUCT_MANUFACTURER := OnePlus")
    content.append("PRODUCT_MODEL := OnePlus 13R")
    content.append("PRODUCT_NAME := oneplus_13r")
    
    # Add build properties
    if "build_props" in config:
        for key, value in config["build_props"].items():
            content.append(f'PRODUCT_PROPERTY_OVERRIDES += \\')
            content.append(f'    {key}={value}')
    
    # Write the updated device.mk
    with open("device/oneplus/13r/device.mk", "w") as f:
        f.write("\n".join(content))
    
    print("Updated device.mk")

def main():
    # Create necessary directories
    os.makedirs("device/oneplus/13r", exist_ok=True)
    
    # Update files
    update_proprietary_files()
    update_device_config()
    
    print("\nDevice tree updated successfully!")
    print("Please review the following files:")
    print("1. device/oneplus/13r/proprietary-files.txt")
    print("2. device/oneplus/13r/device.mk")

if __name__ == "__main__":
    main() 