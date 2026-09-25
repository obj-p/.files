# zmodload zsh/zprof
# time zsh -i -c exit

# Completions (revalidate the dump at most once a day)
autoload -U compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit -i
else
  compinit -C
fi

# Atuin
command -v atuin >/dev/null && eval "$(atuin init zsh --disable-ctrl-r)"
command -v fzf >/dev/null && source <(fzf --zsh)

if command -v atuin >/dev/null && command -v fzf >/dev/null; then
  fzf-atuin-history-widget() {
    setopt localoptions pipefail
    local selected
    if selected=$(atuin search --cmd-only --print0 |
      fzf --read0 --print0 --no-multi --scheme=history --height=40% \
        --query="$LBUFFER" --bind=ctrl-r:toggle-sort); then
      BUFFER=${selected%$'\0'}
      CURSOR=${#BUFFER}
    fi
    zle reset-prompt
  }

  zle -N fzf-atuin-history-widget
  bindkey -M emacs "^R" fzf-atuin-history-widget
  bindkey -M viins "^R" fzf-atuin-history-widget
  bindkey -M vicmd "^R" fzf-atuin-history-widget
fi

# direnv
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# mise
eval "$(mise activate zsh)"

# orbstack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# make
zstyle ":completion:*:make:*:targets" call-command true
zstyle ":completion:*:*:make:*" tag-order "targets"

# plx
command -v plx >/dev/null && eval "$(plx completion zsh)"

# neovim
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# zoxide
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# zprof
