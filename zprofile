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
export PATH="$HOME/.claude/local:$PATH"

# direnv
eval "$(direnv hook zsh)"

# mise
eval "$(mise activate zsh)"

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
