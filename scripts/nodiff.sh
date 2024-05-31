#!/bin/bash

# Check if at least one argument is passed
if [ $# -eq 0 ]; then
  echo "Usage: $0 <file1> <file2> ... <fileN>"
  exit 1
fi

# Flag to track if any file has a diff
has_diff=false

# Loop through all the files passed as arguments
for file in "$@"; do
  # Check if the file has any changes
  if git diff --quiet "$file"; then
    echo "No changes in $file"
  else
    echo "Changes detected in $file"
    has_diff=true
    files_with_diff+=("$file")
  fi
done

# Print the files that have a diff
if [ "$has_diff" = true ]; then
  echo "Files with changes:"
  for diff_file in "${files_with_diff[@]}"; do
    echo "$diff_file"
  done
  exit 1
else
  exit 0
fi
