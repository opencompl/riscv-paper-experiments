#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <output_path> <input_path1> [<input_path2> ...]"
    exit 1
fi

output_file="$1"
shift  # Shift to exclude output file

# Get header from the first input file
header=$(head -n 1 "$1")

rm -f "$output_file"

echo "tests,$header" > "$output_file"

while [ "$#" -gt 0 ]; do
    file="$1"

    filename=$(basename "$file" .csv)
    value=$(tail -n +2 "$file")
    echo "$filename,$value" >> "$output_file"

    shift
done
