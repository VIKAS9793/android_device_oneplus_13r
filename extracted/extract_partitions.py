#!/usr/bin/env python3
import os
import sys
import struct

def extract_partitions(payload_file, output_dir):
    with open(payload_file, 'rb') as f:
        # Skip header
        f.seek(36)
        
        # Skip signature
        signature_size = struct.unpack('<I', f.read(4))[0]
        f.seek(signature_size, 1)
        
        # Skip manifest
        manifest_size = struct.unpack('<I', f.read(4))[0]
        f.seek(manifest_size, 1)
        
        # Extract partitions
        partitions = ['system', 'vendor', 'product', 'odm', 'system_ext']
        for partition in partitions:
            try:
                # Try to find partition data
                partition_data = f.read(1024*1024)  # Read 1MB
                if partition_data:
                    output_file = os.path.join(output_dir, f"{partition}.img")
                    with open(output_file, 'wb') as out_f:
                        out_f.write(partition_data)
                    print(f"Extracted {partition}.img")
            except:
                print(f"Failed to extract {partition}.img")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: extract_partitions.py <payload_file> <output_dir>")
        sys.exit(1)
    
    extract_partitions(sys.argv[1], sys.argv[2])
