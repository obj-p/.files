#!/usr/bin/env bash

ACTION="$1"
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
    "zprofile:$HOME/.zprofile"
    "tmux.conf:$HOME/.tmux.conf"
    "iterm2/profile.json:$HOME/Library/Application Support/iTerm2/DynamicProfiles/profile.json"
    "AGENTS.md:$HOME/.claude/CLAUDE.md"
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
