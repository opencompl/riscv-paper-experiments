#!/bin/bash

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <prefix> <output_path> <input_path1> [<input_path2> ...]"
    exit 1
fi

prefix="$1"
shift # Shift to exclude prefix

output_file="$1"
shift  # Shift to exclude output file

# Get header from the first input file
header=$(head -n 1 "$1")

rm -f "$output_file"

echo "$prefix,$header" > "$output_file"

while [ "$#" -gt 0 ]; do
    file="$1"

    filename=$(basename "$file" .csv)
    value=$(tail -n +2 "$file")
    echo "$filename,$value" >> "$output_file"

    shift
done
