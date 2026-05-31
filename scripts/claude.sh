#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STATUSLINE_PATH="$SCRIPT_DIR/claude_statusline.sh"
SETTINGS_FILE="$HOME/.claude/settings.json"

mkdir -p "$(dirname "$SETTINGS_FILE")"

# Initialize settings file if it doesn't exist
if [[ ! -f "$SETTINGS_FILE" ]]; then
  echo "{}" > "$SETTINGS_FILE"
fi

# Configure statusline
jq --arg cmd "$STATUSLINE_PATH" \
  '.statusLine = {"type": "command", "command": $cmd}' \
  "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"

# Configure rules reinjection hook
# shellcheck disable=SC2016
HOOK_CMD='printf "<system-reminder>\n"; cat "$HOME/.claude/CLAUDE.md"; printf "\n</system-reminder>\n"'
jq --arg cmd "$HOOK_CMD" \
  '.hooks.UserPromptSubmit = [{"hooks": [{"type": "command", "command": $cmd}]}]' \
  "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"

# Add plugins marketplace
claude plugin marketplace add obj-p/claude-plugins
