#!/bin/bash

# Get the commit message
commit_message=$(cat "$1")

# Define the conventional commit regex
conventional_commit_regex='^(build|chore|ci|docs|feat|fix|perf|refactor|revert|style|test)(\(.+\))?: .+'

# Check if the commit message matches the conventional commit format
if ! [[ $commit_message =~ $conventional_commit_regex ]]; then
  echo "ERROR: Commit message does not follow the conventional commit format!"
  exit 1
fi
