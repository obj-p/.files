# Sourced by every zsh (login, interactive, and scripts). Keep it to
# environment variables and PATH; interactive setup belongs in zshrc.
# Prepending an existing entry moves it to the front, so this file is safe
# to source more than once; zprofile relies on that.
typeset -U path PATH
export PATH

# Homebrew: shellenv once per process tree, PATH re-asserted every time
[[ -z "$HOMEBREW_PREFIX" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $path)

export EDITOR=nvim

# Go
export GOPATH="$HOME/go"
path=("$GOPATH/bin" $path)

# lean4
path=("$HOME/.elan/bin" $path)

# LM Studio
path=($path "$HOME/.lmstudio/bin")

# mise: shims give non-interactive shells the managed toolchains.
# zshrc's `mise activate` adds the shell function and prompt hooks on top.
path=("$HOME/.local/share/mise/shims" $path)

# user-installed CLIs
path=("$HOME/.local/bin" $path)
