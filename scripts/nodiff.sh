#!/bin/bash

# Check if exactly two arguments are passed
if [ $# -ne 2 ]; then
  echo "Usage: $0 <file1> <file2>"
  exit 1
fi

file1="$1"
file2="$2"

# Compare the two files
if diff "$file1" "$file2" > /dev/null; then
  echo "Files are identical: $file1 and $file2"
  exit 0
else
  echo "Files differ: $file1 and $file2"
  exit 1
fi
