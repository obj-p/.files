#!/usr/bin/env bash

if ! command -v mise &> /dev/null; then
    echo "Error: mise is not installed."
    exit 1
fi

PACKAGES=(
    "@anthropic-ai/claude-code"
    "@devcontainers/cli"
    "@elgato/cli"
    "@openai/codex"
    "npm@11.4.2"
)

GLOBAL_VERSION="22.17.0"

# Install Node.js if not already installed
if ! mise ls node | grep -q "$GLOBAL_VERSION"; then
    mise use --global "node@$GLOBAL_VERSION"
fi

# Install global npm packages
for package in "${PACKAGES[@]}"; do
    mise exec -- npm install -g "$package"
done
