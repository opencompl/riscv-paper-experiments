#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <output_path> <input_path1> [<input_path2> ...]"
    exit 1
fi

output_file="$1"
shift  # Shift to exclude the first argument

rm -f "$output_file"

while [ "$#" -gt 0 ]; do
    file="$1"

	pattern=$(echo $file | sed 's/[^/]*\/\([^/]*\)\/.*/\1/')
    awk -v pattern="$pattern" '{print pattern "," $0}' $file >> "$output_file"

    shift
done
