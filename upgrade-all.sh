#!/bin/bash

# Exit script if any command fails
set -e

# Logging function
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') $@"
}

# Update Homebrew
if command -v brew > /dev/null; then
    log "Updating Homebrew..."
    brew update && brew upgrade && brew cleanup
fi

# Update npm
if command -v npm > /dev/null; then
    log "Updating npm packages..."
    npm update -g
fi

# Update Ruby Gems
if command -v gem > /dev/null; then
    log "Updating Ruby Gems..."
    gem update --system && gem update
fi

# Update pip
if command -v pip > /dev/null; then
    log "Updating pip packages..."
    pip install --upgrade pip
fi
