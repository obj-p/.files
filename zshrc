autoload -Uz compinit && compinit

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# make
zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:*:make:*' tag-order 'targets'

# pipx
export PATH="$HOME/.local/bin:$PATH"
