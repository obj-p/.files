#!/usr/bin/env bash

PLUGIN_PATH="$1"
SETTINGS_FILE="$HOME/.claude/settings.json"

mkdir -p "$(dirname "$SETTINGS_FILE")"

# Start with existing settings or empty object
if [[ -f "$SETTINGS_FILE" ]]; then
    existing=$(cat "$SETTINGS_FILE")
else
    existing="{}"
fi

# Merge in the plugin configuration
echo "$existing" | jq --arg path "$PLUGIN_PATH" '
  .extraKnownMarketplaces["dotfiles-marketplace"] = {
    "source": {
      "source": "directory",
      "path": $path
    }
  } |
  .enabledPlugins["dotfiles@dotfiles-marketplace"] = true
' > "$SETTINGS_FILE"

echo "Claude plugin configured at $PLUGIN_PATH"
