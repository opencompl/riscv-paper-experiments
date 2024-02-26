#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <output_path> <input_path1> [<input_path2> ...]"
    exit 1
fi

output_file="$1"
shift  # Shift to exclude the first argument

rm -f "$output_file"

# Get header from the first input file
header=$(head -n 1 "$1")

echo "params,$header" > "$output_file"

while [ "$#" -gt 0 ]; do
    file="$1"

	pattern=$(echo $file | sed 's/[^/]*\/\([^/]*\)\/.*/\1/')
    tail -n +2 "$file" | awk -v pattern="$pattern" '{print pattern "," $0}' >> "$output_file"

    shift
done
