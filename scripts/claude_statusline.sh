#!/usr/bin/env bash

# ANSI color codes
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
MAGENTA='\033[35m'
RESET='\033[0m'

# Read JSON from stdin
json=$(cat)

# Extract values using jq
session_id=$(echo "$json" | jq -r '.session_id // "Unknown"')
transcript=$(echo "$json" | jq -r '.transcript_path // ""')

# Get custom title from transcript
conversation="$session_id"
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
    custom_title=$(grep '"type":"custom-title"' "$transcript" 2>/dev/null | jq -r '.customTitle // empty' | tail -1)
    [ -n "$custom_title" ] && conversation="$custom_title"
fi

# Get cwd and git branch
cwd_full=$(echo "$json" | jq -r '.cwd // "Unknown"')
git_branch=$(git -C "$cwd_full" rev-parse --abbrev-ref HEAD 2>/dev/null)
cwd="${cwd_full##*/}"
[ -n "$git_branch" ] && cwd="$cwd ($git_branch)"
model=$(echo "$json" | jq -r '.model.display_name // "Unknown"')
context_pct=$(echo "$json" | jq -r '.context_window.used_percentage // 0')
context_size=$(echo "$json" | jq -r '.context_window.context_window_size // 0')

# Calculate remaining tokens
remaining=$(echo "scale=0; $context_size * (100 - $context_pct) / 100" | bc)

# Format tokens with K suffix
format_tokens() {
    local tokens=$1
    if [ "$tokens" -ge 1000 ]; then
        printf "%.1fK" "$(echo "scale=1; $tokens / 1000" | bc)"
    else
        echo "$tokens"
    fi
}

tokens_remaining=$(format_tokens "$remaining")

# Color based on usage
pct_int=${context_pct%.*}
if [ "$pct_int" -lt 50 ]; then
    pct_color=$GREEN
elif [ "$pct_int" -lt 70 ]; then
    pct_color=$YELLOW
else
    pct_color=$RED
fi

context_pct=$(printf "%.0f" "$context_pct")

printf "${MAGENTA}%s${RESET} | ${CYAN}%s${RESET} | %s | Context ${pct_color}%s%%${RESET} | Tokens ~%s\n" \
    "$conversation" "$cwd" "$model" "$context_pct" "$tokens_remaining"
