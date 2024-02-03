#!/bin/bash

# Get list of changed JavaScript files
js_files=$(git diff --cached --name-only --diff-filter=ACM | grep "\.js$")
rb_files=$(git diff --cached --name-only --diff-filter=ACM | grep "\.rb$")

# Run ESLint on each file
for file in $js_files; do
  git show ":$file" | eslint --stdin --stdin-filename "$file"
  if [ $? -ne 0 ]; then
    echo "ESLint failed on staged file '$file'. Please check your code and try again."
    exit 1 # exit with failure status
  fi
done

# Run RuboCop on each Ruby file
for file in $rb_files; do
  git show ":$file" | rubocop --stdin "$file"
  if [ $? -ne 0 ]; then
    echo "RuboCop failed on staged file '$file'. Please check your code and try again."
    exit 1 # exit with failure status
  fi
done
