#!/usr/bin/env bash

ACTION="$1"
LINKS=(
    "nvim:$HOME/.config/nvim"
    "Brewfile:$HOME/Brewfile"
    "mise.toml:$HOME/.config/mise/config.toml"
    "zprofile:$HOME/.zprofile"
    "tmux.conf:$HOME/.tmux.conf"
    "iterm2/profile.json:$HOME/Library/Application Support/iTerm2/DynamicProfiles/profile.json"
)

for entry in "${LINKS[@]}"; do
    IFS=":" read -r src dest <<< "$entry"

    if [[ "$ACTION" == "clean" ]]; then
        rm -f "$dest"
    else
        mkdir -p "$(dirname "$dest")"
        ln -nsf "$(realpath "$src")" "$dest"
    fi
done
