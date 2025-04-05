#!/usr/bin/env python3
import os
import sys
import struct
import zlib
import binascii
import hashlib
import subprocess

class PayloadError(Exception):
    """Custom exception for payload parsing errors."""
    pass

def read_uint64(f):
    """Read an unsigned 64-bit integer from file."""
    return struct.unpack('>Q', f.read(8))[0]

def read_uint32(f):
    """Read an unsigned 32-bit integer from file."""
    return struct.unpack('>I', f.read(4))[0]

def read_string(f):
    """Read a string from file."""
    length = read_uint32(f)
    return f.read(length).decode('utf-8')

def extract_partition(payload_file, output_dir, partition_name, offset, size):
    """Extract a partition from the payload file."""
    print(f"Extracting {partition_name}...")
    
    # Create output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)
    
    # Open the payload file
    with open(payload_file, 'rb') as f:
        # Seek to the partition offset
        f.seek(offset)
        
        # Read the partition data
        data = f.read(size)
        
        # Write the partition data to a file
        output_file = os.path.join(output_dir, f"{partition_name}.img")
        with open(output_file, 'wb') as out:
            out.write(data)
        
        print(f"Extracted {partition_name} to {output_file}")
        return output_file

def main():
    if len(sys.argv) != 3:
        print("Usage: python payload_dumper.py <payload_file> <output_dir>")
        sys.exit(1)

    payload_file = sys.argv[1]
    output_dir = sys.argv[2]

    if not os.path.exists(payload_file):
        print(f"Error: Payload file {payload_file} does not exist")
        sys.exit(1)

    print(f"Opening payload file: {payload_file}")
    with open(payload_file, 'rb') as f:
        # Read file size
        f.seek(0, 2)
        file_size = f.tell()
        f.seek(0)
        print(f"Payload file size: {file_size} bytes")

        # Read and verify magic
        magic = f.read(4)
        if magic != b'CrAU':
            print(f"Warning: Invalid magic bytes: {magic}")
            print("Continuing anyway...")
            f.seek(0)
        else:
            print("Found valid CrAU magic bytes")

        # Read version
        version = read_uint64(f)
        print(f"Payload version: {version}")

        # Read manifest size
        manifest_size = read_uint64(f)
        print(f"Manifest size: {manifest_size} bytes")

        # Read metadata signature size
        metadata_signature_size = read_uint32(f)
        print(f"Metadata signature size: {metadata_signature_size} bytes")

        # Calculate offsets
        header_size = 24  # 4 (magic) + 8 (version) + 8 (manifest_size) + 4 (metadata_signature_size)
        data_offset = header_size + manifest_size + metadata_signature_size
        print(f"Data offset: {data_offset} bytes")

        # Common partition names and their approximate sizes
        partitions = {
            'system': 0x10000000,  # 256MB
            'vendor': 0x8000000,   # 128MB
            'product': 0x4000000,  # 64MB
            'odm': 0x2000000,      # 32MB
            'system_ext': 0x4000000  # 64MB
        }

        # Extract each partition
        for name, size in partitions.items():
            try:
                extract_partition(payload_file, output_dir, name, data_offset, size)
            except Exception as e:
                print(f"Error extracting {name}: {e}")

        print("\nExtraction complete!")
        print(f"Extracted files are in: {output_dir}")

if __name__ == '__main__':
    main()
