#!/bin/bash

# Get the list of modified files
modified_files=$(git diff --name-only --diff-filter=ACM)

# Arrays to hold RSpec and Cucumber files
rspec_files=()
cucumber_files=()

# Loop through the modified files
for file in $modified_files; do
  if [[ $file == *_spec.rb ]]; then
    rspec_files+=("$file")
  elif [[ $file == *.feature ]]; then
    cucumber_files+=("$file")
  else
    # Strip the extension and path, then look for corresponding spec file
    base_name=$(basename "$file" .rb)
    potential_spec="spec/${file%/*}/${base_name}_spec.rb"

    # Check if the spec file exists
    if [[ -f $potential_spec ]]; then
      rspec_files+=("$potential_spec")
    fi
  fi
done

# Run RSpec if there are any spec files
if [ ${#rspec_files[@]} -gt 0 ]; then
  echo "Running RSpec on the following files:"
  printf '%s\n' "${rspec_files[@]}"
  rspec "${rspec_files[@]}"
else
  echo "No RSpec files to run."
fi

# Run Cucumber if there are any feature files
if [ ${#cucumber_files[@]} -gt 0 ]; then
  echo "Running Cucumber on the following files:"
  printf '%s\n' "${cucumber_files[@]}"
  cucumber "${cucumber_files[@]}"
else
  echo "No Cucumber files to run."
fi
