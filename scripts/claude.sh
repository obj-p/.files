#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STATUSLINE_PATH="$SCRIPT_DIR/claude_statusline.sh"
SETTINGS_FILE="$HOME/.claude/settings.json"

mkdir -p "$(dirname "$SETTINGS_FILE")"

# Cleanup plugin cache
echo "Cleaning up plugin cache..."
rm -rf "$HOME/.claude/plugins/cache"

# Start with empty settings (clean slate)
existing="{}"

# Configure marketplace and statusline
echo "$existing" | jq --arg statusline "$STATUSLINE_PATH" '
  .extraKnownMarketplaces["claude-plugins"] = {
    "source": {
      "source": "github",
      "owner": "obj-p",
      "repo": "claude-plugins"
    }
  } |
  .statusLine = {
    "type": "command",
    "command": $statusline
  }
' > "$SETTINGS_FILE"

echo "Claude plugins configured from github:obj-p/claude-plugins"
