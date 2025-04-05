#!/usr/bin/env python3
import os
import sys
import subprocess
import json
from pathlib import Path

def analyze_file(file_path):
    """Analyze a file to determine its type and content."""
    try:
        with open(file_path, 'rb') as f:
            header = f.read(16)
            
            # Check for common file signatures
            if header.startswith(b'ELF'):
                return 'ELF binary (shared library or executable)'
            elif header.startswith(b'PK\x03\x04'):
                return 'ZIP archive (APK)'
            elif header.startswith(b'\x7F\x45\x4C\x46'):
                return 'ELF binary (shared library or executable)'
            elif header.startswith(b'\x00\x00\x00\x00\x00\x00\x00\x00'):
                return 'Binary data (possibly firmware or configuration)'
            else:
                # Try to determine if it's text
                f.seek(0)
                try:
                    content = f.read(1024).decode('utf-8', errors='ignore')
                    if all(32 <= ord(c) <= 126 or c in '\n\r\t' for c in content):
                        return 'Text file'
                    else:
                        return 'Binary data'
                except:
                    return 'Binary data'
    except Exception as e:
        return f'Error analyzing file: {e}'

def main():
    extracted_dir = Path("C:/Users/vikas/Downloads/Oneplus13r/extracted")
    vendor_dir = extracted_dir / "mounted" / "vendor"
    
    if not vendor_dir.exists():
        print(f"Vendor directory not found: {vendor_dir}")
        return
    
    print("Analyzing proprietary files...")
    
    # Create a list to store file information
    file_info = []
    
    # Analyze each file
    for file_name in os.listdir(vendor_dir):
        file_path = vendor_dir / file_name
        file_type = analyze_file(file_path)
        file_size = os.path.getsize(file_path)
        
        file_info.append({
            'name': file_name,
            'type': file_type,
            'size': file_size,
            'path': f"vendor/{file_name}"
        })
        
        print(f"{file_name}: {file_type} ({file_size} bytes)")
    
    # Save the analysis
    with open(extracted_dir / "proprietary_analysis.json", "w") as f:
        json.dump(file_info, f, indent=4)
    
    # Create a proprietary-files.txt file
    with open(extracted_dir / "proprietary-files.txt", "w") as f:
        for info in file_info:
            f.write(f"{info['path']}\n")
    
    print(f"\nAnalysis complete!")
    print(f"Found {len(file_info)} proprietary files")
    print(f"Analysis saved to: {extracted_dir}/proprietary_analysis.json")
    print(f"Proprietary files list saved to: {extracted_dir}/proprietary-files.txt")

if __name__ == "__main__":
    main() 