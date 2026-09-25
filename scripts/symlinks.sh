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
    "scripts/claude_statusline.sh:$HOME/.local/bin/claude_statusline.sh"
    "gitconfig:$HOME/.gitconfig"
    "karabiner:$HOME/.config/karabiner"
    "iterm2/profile.json:$HOME/Library/Application Support/iTerm2/DynamicProfiles/profile.json"
)

# Pre-flight: refuse to start unless every link can be made.
for entry in "${LINKS[@]}"; do
    IFS=":" read -r src dest <<< "$entry"
    if [[ ! -e "$src" ]]; then
        echo "Missing source $src for $dest" >&2
        exit 1
    fi
    if [[ "$ACTION" != "clean" && -e "$dest" && ! -L "$dest" && -e "$dest.bak" ]]; then
        echo "Both $dest and $dest.bak exist; move one aside and re-run" >&2
        exit 1
    fi
done

for entry in "${LINKS[@]}"; do
    IFS=":" read -r src dest <<< "$entry"

    if [[ "$ACTION" == "clean" ]]; then
        if [[ -L "$dest" ]]; then
            rm "$dest"
        fi
        continue
    fi

    mkdir -p "$(dirname "$dest")"
    if [[ -e "$dest" && ! -L "$dest" ]]; then
        mv "$dest" "$dest.bak"
        echo "Moved existing $dest to $dest.bak (see README: Local-only configuration)"
    fi
    ln -nsf "$(realpath "$src")" "$dest"
done
