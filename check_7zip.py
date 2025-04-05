#!/usr/bin/env python3
import os
import sys
import subprocess
import urllib.request
import winreg

def check_7zip():
    """Check if 7-Zip is installed."""
    try:
        # Check if 7-Zip is in PATH
        subprocess.run(['7z'], capture_output=True)
        return True
    except FileNotFoundError:
        return False

def install_7zip():
    """Download and install 7-Zip."""
    print("7-Zip not found. Installing...")
    
    # Download 7-Zip installer
    url = "https://www.7-zip.org/a/7z2301-x64.exe"
    installer = "7z-installer.exe"
    
    print("Downloading 7-Zip...")
    urllib.request.urlretrieve(url, installer)
    
    # Run the installer
    print("Installing 7-Zip...")
    subprocess.run([installer, '/S'], check=True)
    
    # Clean up
    os.remove(installer)
    
    print("7-Zip installed successfully!")
    return True

def main():
    if not check_7zip():
        if not install_7zip():
            print("Failed to install 7-Zip. Please install it manually from https://www.7-zip.org/")
            sys.exit(1)
    
    print("7-Zip is installed and ready to use!")
    return True

if __name__ == "__main__":
    main() 