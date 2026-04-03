#!/usr/bin/python3
"""
Locates and replaces a string in the heap of a running process.
Usage: ./read_write_heap.py pid search_string replace_string
"""

import sys
import os

def print_usage_and_exit():
    print("Usage: {} pid search_string replace_string".format(sys.argv[0]))
    sys.exit(1)

def read_write_heap():
    # 1. Validation of arguments
    if len(sys.argv) != 4:
        print_usage_and_exit()

    pid = sys.argv[1]
    search_string = sys.argv[2]
    replace_string = sys.argv[3]

    if not pid.isdigit():
        print("Error: PID must be a number")
        print_usage_and_exit()

    # 2. Open the maps file to find the heap range
    maps_filename = "/proc/{}/maps".format(pid)
    mem_filename = "/proc/{}/mem".format(pid)

    try:
        with open(maps_filename, 'r') as maps_file:
            heap_start = None
            heap_end = None

            for line in maps_file:
                if "[heap]" in line:
                    # Line format: 555e646e0000-555e64701000 rw-p 00000000 00:00 0 [heap]
                    parts = line.split()
                    addr_range = parts[0].split('-')
                    heap_start = int(addr_range[0], 16)
                    heap_end = int(addr_range[1], 16)
                    print("[*] Found heap at: {:x} - {:x}".format(heap_start, heap_end))
                    break

            if heap_start is None or heap_end is None:
                print("[!] Could not find heap for process {}".format(pid))
                sys.exit(1)

        # 3. Open the mem file and perform the replacement
        # Permissions: need sudo to write to /proc/[pid]/mem
        with open(mem_filename, 'rb+') as mem_file:
            # Seek to the start of the heap
            mem_file.seek(heap_start)
            heap_data = mem_file.read(heap_end - heap_start)

            # Find the index of the search string
            try:
                i = heap_data.index(search_string.encode('ascii'))
            except ValueError:
                print("[!] Search string '{}' not found in heap".format(search_string))
                sys.exit(1)

            print("[*] Found '{}' at offset: {:x}".format(search_string, i))

            # Seek to the specific address in the file
            mem_file.seek(heap_start + i)
            
            # Write the replacement string (null-terminated if you want to be safe)
            mem_file.write(replace_string.encode('ascii') + b'\0')
            print("[*] Successfully replaced with '{}'".format(replace_string))

    except IOError as e:
        print("[!] Error accessing process files: {}".format(e))
        sys.exit(1)

if __name__ == "__main__":
    read_write_heap()
