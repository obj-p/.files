#!/usr/bin/env bash

PLUGIN_PATH="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STATUSLINE_PATH="$SCRIPT_DIR/claude_statusline.sh"
SETTINGS_FILE="$HOME/.claude/settings.json"

mkdir -p "$(dirname "$SETTINGS_FILE")"

# Cleanup plugin cache
echo "Cleaning up plugin cache..."
rm -rf "$HOME/.claude/plugins/cache"

# Start with empty settings (clean slate)
existing="{}"

# Configure marketplace and statusline only (plugins installed separately)
echo "$existing" | jq --arg path "$PLUGIN_PATH" --arg statusline "$STATUSLINE_PATH" '
  .extraKnownMarketplaces["dotfiles-marketplace"] = {
    "source": {
      "source": "directory",
      "path": $path
    }
  } |
  .statusLine = {
    "type": "command",
    "command": $statusline
  }
' > "$SETTINGS_FILE"

echo "Claude plugin configured at $PLUGIN_PATH"
