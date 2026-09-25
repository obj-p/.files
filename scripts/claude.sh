#!/usr/bin/env bash

set -euo pipefail

TEMPLATE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/claude/settings.json"
SETTINGS_FILE="$HOME/.claude/settings.json"

mkdir -p "$(dirname "$SETTINGS_FILE")"
[[ -s "$SETTINGS_FILE" ]] || echo "{}" > "$SETTINGS_FILE"

# Deep-merge the template over the live file. Keys the template does not
# mention (hooks, marketplaces, plugin state Claude Code writes) survive.
jq -s '.[0] * .[1]' "$SETTINGS_FILE" "$TEMPLATE" > "$SETTINGS_FILE.tmp"
mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
