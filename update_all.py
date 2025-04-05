#!/usr/bin/env python3
import os
import json
import shutil
from pathlib import Path

def ensure_dir(path):
    """Ensure directory exists, create if it doesn't"""
    Path(path).mkdir(parents=True, exist_ok=True)

def update_proprietary_files():
    # Read the proprietary files list
    with open("extracted/proprietary-files.txt", "r") as f:
        proprietary_files = [line.strip() for line in f if line.strip()]
    
    # Create the proprietary-files.txt content
    content = []
    content.append("# Proprietary files for OnePlus 13R")
    content.append("# Generated from firmware analysis")
    content.append("")
    
    # Add files by type
    content.append("# Shared libraries")
    for file in proprietary_files:
        if file.endswith(".so"):
            content.append(file)
    
    content.append("\n# Binary files")
    for file in proprietary_files:
        if file.endswith(".bin"):
            content.append(file)
    
    content.append("\n# APK files")
    for file in proprietary_files:
        if file.endswith(".apk"):
            content.append(file)
    
    # Write the updated proprietary-files.txt
    ensure_dir("device/oneplus/13r")
    with open("device/oneplus/13r/proprietary-files.txt", "w") as f:
        f.write("\n".join(content))
    
    print("Updated proprietary-files.txt")

def update_device_config():
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
    
    # Write the updated device.mk
    ensure_dir("device/oneplus/13r")
    with open("device/oneplus/13r/device.mk", "w") as f:
        f.write("\n".join(content))
    
    print("Updated device.mk")

def update_overlay_config():
    # Create the overlay config content
    content = []
    content.append('<?xml version="1.0" encoding="utf-8"?>')
    content.append('<resources>')
    content.append('    <!-- OnePlus 13R specific configurations -->')
    content.append('    <bool name="config_hasFingerprint">true</bool>')
    content.append('    <bool name="config_hasNfc">true</bool>')
    content.append('    <bool name="config_hasWifi">true</bool>')
    content.append('    <bool name="config_hasBluetooth">true</bool>')
    content.append('    <bool name="config_hasBluetoothLe">true</bool>')
    content.append('    <bool name="config_hasBluetoothLeAudio">true</bool>')
    content.append('    <bool name="config_hasBluetoothLeAudioBroadcast">true</bool>')
    content.append('    <bool name="config_hasBluetoothLeAudioUnicast">true</bool>')
    content.append('    <bool name="config_hasBluetoothLeAudioUnicastClient">true</bool>')
    content.append('    <bool name="config_hasBluetoothLeAudioUnicastServer">true</bool>')
    content.append('    <bool name="config_hasBluetoothLeAudioUnicastClientServer">true</bool>')
    content.append('    <bool name="config_hasBluetoothLeAudioUnicastClientServerBroadcast">true</bool>')
    content.append('    <bool name="config_hasBluetoothLeAudioUnicastClientServerBroadcastSink">true</bool>')
    content.append('    <bool name="config_hasBluetoothLeAudioUnicastClientServerBroadcastSource">true</bool>')
    content.append('    <bool name="config_hasBluetoothLeAudioUnicastClientServerBroadcastSinkSource">true</bool>')
    content.append('    <bool name="config_hasBluetoothLeAudioUnicastClientServerBroadcastSinkSourceSink">true</bool>')
    content.append('    <bool name="config_hasBluetoothLeAudioUnicastClientServerBroadcastSinkSourceSource">true</bool>')
    content.append('    <bool name="config_hasBluetoothLeAudioUnicastClientServerBroadcastSinkSourceSinkSource">true</bool>')
    content.append('</resources>')
    
    # Write the updated overlay config
    ensure_dir("device/oneplus/13r/overlay/device/oneplus/13r")
    with open("device/oneplus/13r/overlay/device/oneplus/13r/config.xml", "w") as f:
        f.write("\n".join(content))
    
    print("Updated overlay config.xml")

def main():
    # Update all files
    update_proprietary_files()
    update_device_config()
    update_overlay_config()
    
    print("\nDevice tree updated successfully!")
    print("Please review the following files:")
    print("1. device/oneplus/13r/proprietary-files.txt")
    print("2. device/oneplus/13r/device.mk")
    print("3. device/oneplus/13r/overlay/device/oneplus/13r/config.xml")

if __name__ == "__main__":
    main() 