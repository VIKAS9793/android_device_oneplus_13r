#!/usr/bin/env python3
import os
import json
from pathlib import Path

def ensure_dir(path):
    """Ensure directory exists, create if it doesn't"""
    Path(path).mkdir(parents=True, exist_ok=True)

def update_proprietary_files():
    """Update the proprietary files list"""
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
    ensure_dir("device/oneplus/13r")
    with open("device/oneplus/13r/proprietary-files.txt", "w") as f:
        f.write("\n".join(content))
    
    print("Updated proprietary-files.txt")

def update_device_mk():
    """Update the device.mk file"""
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
    
    # Add common properties
    content.append("\n# Common properties")
    content.append("PRODUCT_PROPERTY_OVERRIDES += \\")
    content.append("    ro.build.characteristics=default")
    
    # Write the file
    ensure_dir("device/oneplus/13r")
    with open("device/oneplus/13r/device.mk", "w") as f:
        f.write("\n".join(content))
    
    print("Updated device.mk")

def update_overlay_config():
    """Update the overlay configuration"""
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
    
    # Write the file
    ensure_dir("device/oneplus/13r/overlay/device/oneplus/13r")
    with open("device/oneplus/13r/overlay/device/oneplus/13r/config.xml", "w") as f:
        f.write("\n".join(content))
    
    print("Updated overlay config.xml")

def main():
    try:
        # Update all files
        update_proprietary_files()
        update_device_mk()
        update_overlay_config()
        
        print("\nDevice tree updated successfully!")
        print("Please review the following files:")
        print("1. device/oneplus/13r/proprietary-files.txt")
        print("2. device/oneplus/13r/device.mk")
        print("3. device/oneplus/13r/overlay/device/oneplus/13r/config.xml")
        
    except Exception as e:
        print(f"Error updating device tree: {str(e)}")
        return 1
    
    return 0

if __name__ == "__main__":
    exit(main()) 