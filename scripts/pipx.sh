#!/usr/bin/env bash

DEPENDENCIES=(
    "pre-commit"
    "pymobiledevice3"
)

for entry in "${DEPENDENCIES[@]}"; do
    pipx install "$entry"
done
