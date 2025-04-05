#!/usr/bin/env python3
import os
import json
from pathlib import Path

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
    with open("device/oneplus/13r/overlay/device/oneplus/13r/config.xml", "w") as f:
        f.write("\n".join(content))
    
    print("Updated overlay config.xml")

def main():
    # Create necessary directories
    os.makedirs("device/oneplus/13r/overlay/device/oneplus/13r", exist_ok=True)
    
    # Update files
    update_device_config()
    update_overlay_config()
    
    print("\nDevice configuration updated successfully!")
    print("Please review the following files:")
    print("1. device/oneplus/13r/device.mk")
    print("2. device/oneplus/13r/overlay/device/oneplus/13r/config.xml")

if __name__ == "__main__":
    main() 