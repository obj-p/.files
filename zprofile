# Sourced by login shells only, after /etc/zprofile has run path_helper,
# which moves the system directories ahead of everything zshenv added.
source "${ZDOTDIR:-$HOME}/.zshenv"

# GitHub (guard skips the gh fork in shells that already inherited it)
if [[ -z "$GITHUB_PERSONAL_ACCESS_TOKEN" ]] && token="$(gh auth token 2>/dev/null)"; then
  export GITHUB_PERSONAL_ACCESS_TOKEN="$token"
fi
unset token
