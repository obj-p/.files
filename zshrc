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

# Claude Code: SSH sessions may not have access to the login Keychain.
# Check on launch, rather than prompting during every SSH shell startup.
claude() {
  if [[ $OSTYPE != darwin* || -z ${SSH_CONNECTION-} || ! -o interactive || ! -t 0 || ! -t 1 ]]; then
    command claude "$@"
    return $?
  fi

  # Explicit authentication and maintenance commands should run as requested.
  case ${1-} in
    auth|auto-mode|daemon|doctor|gateway|install|logs|mcp|plugin|plugins|project|respawn|rm|setup-token|stop|kill|update|upgrade|ultrareview|self-hosted-runner)
      command claude "$@"
      return $?
      ;;
  esac

  local arg auth_status=0
  for arg in "$@"; do
    case $arg in
      --) break ;;
      -h|--help|-v|--version|-p*|-cp|--print|--print=*|--bare|--bg|--background)
        command claude "$@"
        return $?
        ;;
    esac
  done

  # Exit 1 means logged out; other errors should not trigger a password prompt.
  command claude auth status >/dev/null 2>&1 || auth_status=$?
  if (( auth_status == 1 )); then
    print -u2 -- "Claude's saved login is unavailable. Unlock your macOS login Keychain to try it again."
    command security unlock-keychain "$HOME/Library/Keychains/login.keychain-db" || return $?
  fi

  command claude "$@"
}

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

# Prompt
command -v starship >/dev/null && eval "$(starship init zsh)"

# Autosuggestions, then syntax highlighting (it must be sourced last so it
# can wrap the widgets everything above defined)
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null || :
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null || :

# zprof
