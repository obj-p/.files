#!/usr/bin/env bash

ACTION="$1"
LINKS=(
    "nvim:~/.config/nvim"
    "Brewfile:~/Brewfile"
    "zprofile:~/.zprofile"
)

for entry in "${LINKS[@]}"; do
    IFS=":" read -r src dest <<< "$entry"
    eval src="$src"
    eval dest="$dest"

    if [[ "$ACTION" == "clean" ]]; then
        rm -f "$dest"
    else
        ln -nsf "$(realpath "$src")" "$dest"
    fi
done
