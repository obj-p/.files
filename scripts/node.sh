#!/usr/bin/env bash

export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if ! command -v nvm &> /dev/null; then
    echo "Error: nvm is not installed."
    exit 1
fi

PACKAGES=(
    "@anthropic-ai/claude-code"
    "npm@11.4.2"
)

GLOBAL_VERSION="v22.17.0"

if ! nvm ls --no-colors --no-alias | grep -q "$GLOBAL_VERSION"; then
    nvm install "$GLOBAL_VERSION"
    nvm alias default "$GLOBAL_VERSION"
fi

for package in "${PACKAGES[@]}"; do
    npm install -g "$package"
done
