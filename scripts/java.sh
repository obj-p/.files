#!/usr/bin/env bash

if ! command -v mise &> /dev/null; then
    echo "Error: mise is not installed."
    exit 1
fi

CORRETTO_VERSION="corretto-21"
ZULU_VERSION="zulu-17"

# Install Corretto (default)
if ! mise ls java | grep -q "$CORRETTO_VERSION"; then
    mise use --global "java@$CORRETTO_VERSION"
fi

# Install Zulu
if ! mise ls java | grep -q "$ZULU_VERSION"; then
    mise install "java@$ZULU_VERSION"
fi
