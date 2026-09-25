#!/usr/bin/env bash

set -euo pipefail

ACTION="${1:-}"
PROFILE="${PROFILE:-}"
PROFILE_FILE="$HOME/.config/.files/profile"
if [[ -n "$PROFILE" ]]; then
    mkdir -p "$(dirname "$PROFILE_FILE")"
    echo "$PROFILE" > "$PROFILE_FILE"
elif [[ -f "$PROFILE_FILE" ]]; then
    PROFILE="$(<"$PROFILE_FILE")"
fi
BREWFILE="Brewfile"
MISE_CONFIG="mise.toml"
if [[ "$PROFILE" == "mini" ]]; then
    BREWFILE="Brewfile.mini"
    MISE_CONFIG="mise.mini.toml"
fi
LINKS=(
    "nvim:$HOME/.config/nvim"
    "$BREWFILE:$HOME/Brewfile"
    "$MISE_CONFIG:$HOME/.config/mise/config.toml"
    "zshenv:$HOME/.zshenv"
    "zprofile:$HOME/.zprofile"
    "zshrc:$HOME/.zshrc"
    "tmux.conf:$HOME/.config/tmux/tmux.conf"
    "atuin/config.toml:$HOME/.config/atuin/config.toml"
    "iterm2/profile.json:$HOME/Library/Application Support/iTerm2/DynamicProfiles/profile.json"
)

for entry in "${LINKS[@]}"; do
    IFS=":" read -r src dest <<< "$entry"

    if [[ "$ACTION" == "clean" ]]; then
        if [[ -L "$dest" ]]; then
            rm "$dest"
        fi
    else
        mkdir -p "$(dirname "$dest")"
        if [[ -e "$dest" && ! -L "$dest" ]]; then
            mv "$dest" "$dest.bak"
            echo "Backed up existing $dest to $dest.bak"
        fi
        ln -nsf "$(realpath "$src")" "$dest"
    fi
done
