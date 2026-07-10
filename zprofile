# zmodload zsh/zprof
# time zsh -i -c exit

# Completions
autoload -U compinit
compinit -i

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Atuin
eval "$(atuin init zsh)"

# Claude
export CLAUDE_CODE_NO_FLICKER=1
export CLAUDE_CODE_SUBAGENT_MODEL=opus
export PATH="$HOME/.claude/local:$PATH"

# GitHub
if token="$(gh auth token 2>/dev/null)"; then
  export GITHUB_PERSONAL_ACCESS_TOKEN="$token"
fi
unset token

# direnv
eval "$(direnv hook zsh)"

# lean4
export PATH="$HOME/.elan/bin:$PATH"

# mise
eval "$(mise activate zsh)"

# orbstack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# make
zstyle ":completion:*:make:*:targets" call-command true
zstyle ":completion:*:*:make:*" tag-order "targets"

# pipx
export PATH="$HOME/.local/bin:$PATH"

# neovim
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# zoxide
eval "$(zoxide init zsh)"

# zprof
