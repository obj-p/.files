#!/usr/bin/env bash

SETTINGS_DIR="$HOME/.claude"
SETTINGS_FILE="$SETTINGS_DIR/settings.json"

# Resolve plugin directory relative to this script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$(realpath "$SCRIPT_DIR/../claude")"

# Create settings directory if it doesn't exist
mkdir -p "$SETTINGS_DIR"

# Create empty JSON if settings file doesn't exist
if [[ ! -f "$SETTINGS_FILE" ]]; then
    echo '{}' > "$SETTINGS_FILE"
fi

# Use jq to surgically update the settings
jq --arg plugin_dir "$PLUGIN_DIR" '
  .extraKnownMarketplaces = (.extraKnownMarketplaces // {}) |
  .extraKnownMarketplaces["local-dotfiles"] = {
    "source": {
      "source": "directory",
      "path": $plugin_dir
    }
  } |
  .enabledPlugins = (.enabledPlugins // {}) |
  .enabledPlugins["dotfiles@local-dotfiles"] = true
' "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"

echo "✓ Claude Code plugin configured in $SETTINGS_FILE"
echo "✓ Plugin directory: $PLUGIN_DIR"
