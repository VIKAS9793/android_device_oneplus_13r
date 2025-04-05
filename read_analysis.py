#!/usr/bin/env python3
import json
import os
from pathlib import Path

def main():
    analysis_file = Path("C:/Users/vikas/Downloads/Oneplus13r/extracted/proprietary_analysis.json")
    
    if not analysis_file.exists():
        print(f"Analysis file not found: {analysis_file}")
        return
    
    with open(analysis_file, 'r') as f:
        file_info = json.load(f)
    
    print(f"Found {len(file_info)} proprietary files:")
    print("\nFile Analysis:")
    print("-" * 80)
    
    # Group files by type
    file_types = {}
    for info in file_info:
        file_type = info['type']
        if file_type not in file_types:
            file_types[file_type] = []
        file_types[file_type].append(info)
    
    # Print summary by type
    print("\nSummary by file type:")
    for file_type, files in file_types.items():
        print(f"{file_type}: {len(files)} files")
    
    # Print detailed information
    print("\nDetailed file information:")
    for file_type, files in file_types.items():
        print(f"\n{file_type}:")
        for info in files:
            print(f"  {info['name']}: {info['size']} bytes")
    
    # Print proprietary-files.txt content
    print("\nProprietary files list:")
    print("-" * 80)
    with open(Path("C:/Users/vikas/Downloads/Oneplus13r/extracted/proprietary-files.txt"), 'r') as f:
        print(f.read())

if __name__ == "__main__":
    main() 