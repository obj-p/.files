#!/usr/bin/env bash

DEPENDENCIES=(
    "pre-commit"
)

for entry in "${DEPENDENCIES[@]}"; do
    pipx install "$entry"
done
