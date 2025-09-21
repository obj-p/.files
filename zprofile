# rbenv completions
FPATH=~/.rbenv/completions:"$FPATH"

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

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# JetBrains
export PATH="$PATH:/Users/jasonprasad/Library/Application Support/JetBrains/Toolbox/scripts"

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# make
zstyle ":completion:*:make:*:targets" call-command true
zstyle ":completion:*:*:make:*" tag-order "targets"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pipx
export PATH="$HOME/.local/bin:$PATH"

# rbenv
eval "$(rbenv init - --no-rehash zsh)"

# neovim
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# zoxide
eval "$(zoxide init zsh)"
