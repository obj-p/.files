#!/usr/bin/env bash

set -euo pipefail

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [[ ! -d "$TPM_DIR" ]]; then
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

tmux start-server \; set-environment -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.tmux/plugins/"

# clean_plugins treats a missing config as "no plugins" and removes them all.
TMUX_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
if [[ -f "$TMUX_CONF" ]]; then
    "$TPM_DIR/bin/clean_plugins"
fi
"$TPM_DIR/bin/install_plugins"
