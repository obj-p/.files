# zmodload zsh/zprof
# time zsh -i -c exit

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
lazy_nvm() {
        unset -f nvm node npm
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

nvm() {
        lazy_nvm
        nvm $@
}

node() {
        lazy_nvm
        node $@
}

npm() {
        lazy_nvm
        npm $@
}

npx() {
        lazy_nvm
        npx $@
}


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

# zprof
