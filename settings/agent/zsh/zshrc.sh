# Only run in interactive shells
[[ -o interactive ]] || return

# Disable terminal flow control
if [[ -t 0 ]]; then
  stty -ixon
fi

# Load completion system
autoload -Uz compinit
compinit

# Sourcing plugins
source "${ZDOTDIR}/plugins.zsh"

# Don't record duplicates in history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000

# Environment variables
export CLICOLOR=1
export DOCKER_DEFAULT_PLATFORM=linux/amd64
export EDITOR="nvim"
export GIT_CONFIG_GLOBAL="${HOME}/.config/git/.gitconfig"
export VISUAL="nvim"
export XDG_CONFIG_HOME="${HOME}/.config"
export PATH="${HOME}/.local/bin:${PATH}"

# Aliases
alias cleanup='rm ~/.zsh_history && history -p && touch ~/.zsh_history && exit'

# Keychain configuration
KEYCHAIN="${HOME}/Library/Keychains/login.keychain-db"

if ! security show-keychain-info "$KEYCHAIN" >/dev/null 2>&1; then
  echo "Unlocking agent keychain..."
  security unlock-keychain "$KEYCHAIN"
fi

# Starship
if [[ -z ${STARSHIP_SHELL-} ]]; then
  eval "$(starship init zsh)"
fi
