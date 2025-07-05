#!/usr/bin/env bash

if ! command -v pipx &> /dev/null; then
    echo "Error: pipx is not installed."
    exit 1
fi

DEPENDENCIES=(
    "pre-commit"
    "pymobiledevice3"
)

for dependency in "${DEPENDENCIES[@]}"; do
    pipx install "$dependency"
done
