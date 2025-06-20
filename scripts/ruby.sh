#!/usr/bin/env bash

if ! command -v rbenv &> /dev/null; then
    echo "Error: rbenv is not installed."
    exit 1
fi

GEMS=(
    "xcodeproj"
)

GLOBAL_VERSION="3.4.4"

if ! rbenv versions --bare | grep -qx "$GLOBAL_VERSION"; then
    rbenv install "$GLOBAL_VERSION"
    rbenv global "$GLOBAL_VERSION"
fi

for gem in "${GEMS[@]}"; do
    if ! gem list -i "$gem" > /dev/null; then
        gem install "$gem"
    fi
done
