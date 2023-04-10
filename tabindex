#!/bin/bash

# Get directory path from user
echo "Enter directory path:"
read dir_path

# Check if directory exists
if [ ! -d "$dir_path" ]; then
  echo "Directory does not exist"
  exit 1
fi

# Loop through all files in directory
for file in "$dir_path"/*; do
  # Check if file is an HTML file
  if [[ "$file" == *.html ]]; then
    # Check if tabindex attribute exists in file
    if grep -q 'tabindex' "$file"; then
      # Print element with tabindex attribute
      grep -o '<[^>]* tabindex[^>]*>' "$file"
    fi
  fi
done
