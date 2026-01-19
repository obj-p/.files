#!/usr/bin/env bash

PLUGIN_PATH="$1"
SETTINGS_FILE="$HOME/.claude/settings.json"

mkdir -p "$(dirname "$SETTINGS_FILE")"

# Cleanup plugin cache
echo "Cleaning up plugin cache..."
rm -rf "$HOME/.claude/plugins/cache"

# Start with empty settings (clean slate)
existing="{}"

# Merge in the plugin configuration
echo "$existing" | jq --arg path "$PLUGIN_PATH" '
  .extraKnownMarketplaces["dotfiles-marketplace"] = {
    "source": {
      "source": "directory",
      "path": $path
    }
  } |
  .enabledPlugins["git@dotfiles-marketplace"] = true |
  .enabledPlugins["context7@dotfiles-marketplace"] = true |
  .enabledPlugins["playwright@dotfiles-marketplace"] = true |
  .enabledPlugins["chrome-devtools@dotfiles-marketplace"] = true |
  .enabledPlugins["github@dotfiles-marketplace"] = true
' > "$SETTINGS_FILE"

echo "Claude plugin configured at $PLUGIN_PATH"
