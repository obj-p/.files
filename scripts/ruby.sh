#!/usr/bin/env bash

if ! command -v mise &> /dev/null; then
    echo "Error: mise is not installed."
    exit 1
fi

GEMS=(
    "xcodeproj"
)

GLOBAL_VERSION="3.4.4"

# Install Ruby if not already installed
if ! mise ls ruby | grep -q "$GLOBAL_VERSION"; then
    mise use --global "ruby@$GLOBAL_VERSION"
fi

# Install global gems
for gem in "${GEMS[@]}"; do
    if ! mise exec -- gem list -i "$gem" > /dev/null 2>&1; then
        mise exec -- gem install "$gem"
    fi
done
