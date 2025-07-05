# rbenv completions
FPATH=~/.rbenv/completions:"$FPATH"

# Completions
autoload -U compinit
compinit -i

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# JetBrains
export PATH="$PATH:/Users/jasonprasad/Library/Application Support/JetBrains/Toolbox/scripts"

# make
zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:*:make:*' tag-order 'targets'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pipx
export PATH="$HOME/.local/bin:$PATH"

# rbenv
eval "$(rbenv init - --no-rehash zsh)"
