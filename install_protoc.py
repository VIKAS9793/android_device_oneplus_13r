#!/usr/bin/env python3
import os
import sys
import urllib.request
import zipfile
import subprocess
import shutil

def download_file(url, filename):
    """Download a file from a URL."""
    print(f"Downloading {url} to {filename}...")
    urllib.request.urlretrieve(url, filename)
    print(f"Download completed: {filename}")

def run_command(cmd):
    """Run a command and return its output."""
    try:
        output = subprocess.check_output(cmd, stderr=subprocess.STDOUT, universal_newlines=True)
        return output
    except subprocess.CalledProcessError as e:
        print(f"Command failed: {e}")
        print(f"Output: {e.output}")
        return None

def main():
    # Create a temporary directory
    temp_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "temp")
    if not os.path.exists(temp_dir):
        os.makedirs(temp_dir)

    # Download protoc
    protoc_url = "https://github.com/protocolbuffers/protobuf/releases/download/v21.12/protoc-21.12-win64.zip"
    protoc_zip = os.path.join(temp_dir, "protoc.zip")
    download_file(protoc_url, protoc_zip)

    # Extract protoc
    print("Extracting protoc...")
    with zipfile.ZipFile(protoc_zip, 'r') as zip_ref:
        zip_ref.extractall(temp_dir)

    # Move protoc to a permanent location
    protoc_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "protoc")
    if os.path.exists(protoc_dir):
        shutil.rmtree(protoc_dir)
    os.makedirs(protoc_dir)
    
    # Copy protoc files
    for item in os.listdir(os.path.join(temp_dir, "bin")):
        shutil.copy2(os.path.join(temp_dir, "bin", item), protoc_dir)
    for item in os.listdir(os.path.join(temp_dir, "include")):
        shutil.copytree(os.path.join(temp_dir, "include", item), os.path.join(protoc_dir, "include", item))

    # Clean up
    shutil.rmtree(temp_dir)

    # Add protoc to PATH
    protoc_path = os.path.join(protoc_dir, "protoc.exe")
    if os.path.exists(protoc_path):
        print(f"\nProtocol Buffers compiler installed successfully at: {protoc_path}")
        print("\nPlease add the following directory to your PATH:")
        print(protoc_dir)
        print("\nYou can do this by:")
        print("1. Opening System Properties (Win + Pause/Break)")
        print("2. Clicking on 'Advanced system settings'")
        print("3. Clicking on 'Environment Variables'")
        print("4. Under 'System variables', find and select 'Path'")
        print("5. Click 'Edit'")
        print("6. Click 'New'")
        print(f"7. Add this path: {protoc_dir}")
        print("8. Click 'OK' on all windows")
        print("\nAfter adding to PATH, please restart your terminal and run download_payload_dumper.py again")
    else:
        print("Failed to install Protocol Buffers compiler")

if __name__ == "__main__":
    main() 