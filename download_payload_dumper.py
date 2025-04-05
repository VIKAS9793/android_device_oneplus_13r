#!/usr/bin/env python3
#
# Copyright (C) 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
import sys
import urllib.request
import subprocess
import platform
import zipfile
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
    # Create a directory for the payload dumper
    payload_dumper_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "payload_dumper")
    if not os.path.exists(payload_dumper_dir):
        os.makedirs(payload_dumper_dir)
    
    # Install required dependencies
    print("Installing required dependencies...")
    cmd = ["pip", "install", "protobuf"]
    output = run_command(cmd)
    if output:
        print("Dependencies installed successfully.")
    else:
        print("Failed to install dependencies.")
        return

    # Download the protobuf definition file
    proto_url = "https://raw.githubusercontent.com/aosp-mirror/platform_build/master/tools/releasetools/update_metadata.proto"
    proto_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), "update_metadata.proto")
    download_file(proto_url, proto_file)

    # Generate the Python protobuf file
    print("Generating protobuf Python file...")
    cmd = ["protoc", "--python_out=.", proto_file]
    output = run_command(cmd)
    if output:
        print("Protobuf file generated successfully.")
    else:
        print("Failed to generate protobuf file.")
        return
    
    # Download the payload dumper
    if platform.system() == "Windows":
        # Use a different source for the payload dumper
        url = "https://raw.githubusercontent.com/cyxx/extract_android_ota_payload/master/extract_android_ota_payload.py"
        payload_dumper_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), "payload_dumper.py")
        download_file(url, payload_dumper_file)
        print("Payload dumper downloaded successfully.")
    else:
        # For Linux/Mac, use curl to download the script
        print("Downloading payload dumper...")
        output_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), "payload_dumper.py")
        cmd = ["curl", "-o", output_file, "https://raw.githubusercontent.com/cyxx/extract_android_ota_payload/master/extract_android_ota_payload.py"]
        output = run_command(cmd)
        if output:
            print("Payload dumper downloaded successfully.")
        else:
            print("Failed to download payload dumper.")
            return
    
    print("\nPayload dumper is ready to use. Run the following command to extract the payload:")
    print(f"python payload_dumper.py {os.path.join(os.path.dirname(os.path.abspath(__file__)), 'payload.bin')} {os.path.join(os.path.dirname(os.path.abspath(__file__)), 'extracted')}")

if __name__ == "__main__":
    main() 