#!/usr/bin/env python3
import os
import sys
import subprocess
import shutil
import json
import struct
from pathlib import Path

class SparseImage:
    SPARSE_HEADER_MAGIC = 0xED26FF3A
    CHUNK_HEADER_SIZE = 12
    BLOCK_SIZE = 4096

    def __init__(self, image_path):
        self.image_path = image_path
        self.header = None
        self.chunks = []

    def read_header(self):
        with open(self.image_path, 'rb') as f:
            magic = struct.unpack('<I', f.read(4))[0]
            if magic != self.SPARSE_HEADER_MAGIC:
                raise ValueError(f"Invalid sparse image magic: {magic:08x}")
            
            major_version = struct.unpack('<H', f.read(2))[0]
            minor_version = struct.unpack('<H', f.read(2))[0]
            file_hdr_sz = struct.unpack('<H', f.read(2))[0]
            chunk_hdr_sz = struct.unpack('<H', f.read(2))[0]
            blk_sz = struct.unpack('<I', f.read(4))[0]
            total_blks = struct.unpack('<I', f.read(4))[0]
            total_chunks = struct.unpack('<I', f.read(4))[0]
            image_checksum = struct.unpack('<I', f.read(4))[0]

            self.header = {
                'magic': magic,
                'major_version': major_version,
                'minor_version': minor_version,
                'file_hdr_sz': file_hdr_sz,
                'chunk_hdr_sz': chunk_hdr_sz,
                'blk_sz': blk_sz,
                'total_blks': total_blks,
                'total_chunks': total_chunks,
                'image_checksum': image_checksum
            }

    def extract_to_directory(self, output_dir):
        with open(self.image_path, 'rb') as f:
            # Skip header
            f.seek(self.header['file_hdr_sz'])
            
            # Process each chunk
            for i in range(self.header['total_chunks']):
                chunk_type = struct.unpack('<H', f.read(2))[0]
                reserved = struct.unpack('<H', f.read(2))[0]
                chunk_size = struct.unpack('<I', f.read(4))[0]
                total_size = struct.unpack('<I', f.read(4))[0]

                chunk_data = f.read(total_size)
                
                if chunk_type == 0xCAC1:  # RAW chunk
                    with open(os.path.join(output_dir, f'chunk_{i}.raw'), 'wb') as out:
                        out.write(chunk_data)
                elif chunk_type == 0xCAC2:  # FILL chunk
                    with open(os.path.join(output_dir, f'chunk_{i}.fill'), 'wb') as out:
                        out.write(chunk_data)
                elif chunk_type == 0xCAC3:  # DONTCARE chunk
                    continue
                elif chunk_type == 0xCAC4:  # CRC32 chunk
                    with open(os.path.join(output_dir, f'chunk_{i}.crc'), 'wb') as out:
                        out.write(chunk_data)

class PartitionExtractor:
    def __init__(self, extracted_dir):
        self.extracted_dir = Path(extracted_dir)
        self.mount_dir = self.extracted_dir / "mounted"
        self.output_dir = self.extracted_dir / "proprietary"
        self.config_dir = self.extracted_dir / "config"
        
        # Create necessary directories
        self.mount_dir.mkdir(exist_ok=True)
        self.output_dir.mkdir(exist_ok=True)
        self.config_dir.mkdir(exist_ok=True)

    def extract_vendor_files(self):
        """Extract proprietary files from vendor partition."""
        print("Extracting vendor files...")
        vendor_img = self.extracted_dir / "vendor.img"
        
        # Create a list to store proprietary files
        proprietary_files = []
        
        # Mount the vendor image
        mount_point = self.mount_dir / "vendor"
        mount_point.mkdir(exist_ok=True)
        
        try:
            # Try to handle as sparse image
            sparse = SparseImage(vendor_img)
            sparse.read_header()
            sparse.extract_to_directory(mount_point)
            
            # Common directories to check for proprietary files
            vendor_dirs = [
                "bin",
                "etc",
                "firmware",
                "lib",
                "lib64",
                "vendor"
            ]
            
            # Walk through the extracted files
            for root, dirs, files in os.walk(mount_point):
                for file in files:
                    if file.endswith(('.so', '.bin', '.dat', '.fw', '.img', '.elf')):
                        rel_path = os.path.relpath(os.path.join(root, file), mount_point)
                        proprietary_files.append(rel_path)
                        print(f"Found proprietary file: {rel_path}")
        except Exception as e:
            print(f"Error extracting vendor files: {e}")
            print("Trying alternative extraction method...")
            
            # Try direct binary extraction
            try:
                with open(vendor_img, 'rb') as f:
                    data = f.read()
                    # Look for common file signatures
                    signatures = [
                        (b'ELF', '.so'),
                        (b'PK\x03\x04', '.apk'),
                        (b'\x7F\x45\x4C\x46', '.elf'),
                        (b'\x00\x00\x00\x00\x00\x00\x00\x00', '.bin')
                    ]
                    
                    for sig, ext in signatures:
                        pos = 0
                        while True:
                            pos = data.find(sig, pos)
                            if pos == -1:
                                break
                            # Try to determine file size
                            size = 1024 * 1024  # Default 1MB
                            end_pos = min(pos + size, len(data))
                            file_data = data[pos:end_pos]
                            
                            # Save the file
                            file_name = f"proprietary_{len(proprietary_files)}{ext}"
                            file_path = os.path.join(mount_point, file_name)
                            with open(file_path, 'wb') as out:
                                out.write(file_data)
                            
                            proprietary_files.append(file_name)
                            print(f"Found proprietary file: {file_name}")
                            pos = end_pos
            except Exception as e:
                print(f"Error in alternative extraction: {e}")
        
        # Save the list of proprietary files
        with open(self.output_dir / "proprietary-files.txt", "w") as f:
            for file in proprietary_files:
                f.write(f"vendor/{file}\n")
        
        print(f"Found {len(proprietary_files)} proprietary files")
        return proprietary_files

    def analyze_system_config(self):
        """Analyze system partition for device configurations."""
        print("Analyzing system configuration...")
        system_img = self.extracted_dir / "system.img"
        
        config_data = {
            "build_prop": {},
            "device_features": {},
            "audio_config": {},
            "display_config": {},
            "camera_config": {}
        }
        
        try:
            # Try to handle as sparse image
            sparse = SparseImage(system_img)
            sparse.read_header()
            mount_point = self.mount_dir / "system"
            mount_point.mkdir(exist_ok=True)
            sparse.extract_to_directory(mount_point)
            
            # Look for build.prop in extracted files
            for root, dirs, files in os.walk(mount_point):
                if "build.prop" in files:
                    build_prop_path = os.path.join(root, "build.prop")
                    with open(build_prop_path, 'r', encoding='utf-8', errors='ignore') as f:
                        for line in f:
                            if '=' in line and not line.startswith('#'):
                                key, value = line.strip().split('=', 1)
                                config_data["build_prop"][key] = value
                    break
        except Exception as e:
            print(f"Error analyzing system config: {e}")
            print("Trying alternative method...")
            
            # Try direct binary extraction
            try:
                with open(system_img, 'rb') as f:
                    data = f.read()
                    # Look for build.prop content
                    build_prop_start = data.find(b'ro.build.')
                    if build_prop_start != -1:
                        build_prop_end = data.find(b'\n\n', build_prop_start)
                        if build_prop_end == -1:
                            build_prop_end = len(data)
                        
                        build_prop_content = data[build_prop_start:build_prop_end].decode('utf-8', errors='ignore')
                        for line in build_prop_content.split('\n'):
                            if '=' in line and not line.startswith('#'):
                                key, value = line.strip().split('=', 1)
                                config_data["build_prop"][key] = value
            except Exception as e:
                print(f"Error in alternative analysis: {e}")
        
        # Save configurations
        with open(self.config_dir / "device_config.json", "w") as f:
            json.dump(config_data, f, indent=4)
        
        print("System configuration analysis complete")
        return config_data

    def update_device_tree(self, config_data):
        """Update device tree with extracted information."""
        print("Updating device tree...")
        
        # Create device tree update script
        update_script = self.config_dir / "update_device_tree.sh"
        with open(update_script, "w") as f:
            f.write("#!/bin/bash\n\n")
            f.write("# Update device tree with extracted information\n\n")
            
            # Add build.prop information
            f.write("# Update build.prop information\n")
            for key, value in config_data["build_prop"].items():
                if key.startswith(("ro.product.", "ro.build.")):
                    f.write(f"sed -i 's|{key}=.*|{key}={value}|g' device/oneplus/13r/system.prop\n")
            
            # Add proprietary files
            f.write("\n# Update proprietary files\n")
            f.write("cat > device/oneplus/13r/proprietary-files.txt << 'EOL'\n")
            with open(self.output_dir / "proprietary-files.txt", "r") as pf:
                f.write(pf.read())
            f.write("EOL\n")
        
        print("Device tree update script created")
        return update_script

def main():
    if len(sys.argv) != 2:
        print("Usage: python extract_proprietary.py <extracted_dir>")
        sys.exit(1)
    
    extracted_dir = sys.argv[1]
    extractor = PartitionExtractor(extracted_dir)
    
    # Extract vendor files
    proprietary_files = extractor.extract_vendor_files()
    
    # Analyze system configuration
    config_data = extractor.analyze_system_config()
    
    # Update device tree
    update_script = extractor.update_device_tree(config_data)
    
    print("\nExtraction and analysis complete!")
    print(f"Proprietary files list: {extractor.output_dir}/proprietary-files.txt")
    print(f"Device configuration: {extractor.config_dir}/device_config.json")
    print(f"Device tree update script: {update_script}")

if __name__ == "__main__":
    main() 