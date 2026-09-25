#!/usr/bin/env bash

ACTION="$1"
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
