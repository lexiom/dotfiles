# Only run in interactive shells
[[ -o interactive ]] || return

# Load completion system
autoload -Uz compinit
compinit

# Sourcing plugins
source "$ZDOTDIR/plugins.zsh"

# Don't record duplicates in history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Environment variables
export CLICOLOR=1
export GIT_CONFIG_GLOBAL="$HOME/.config/git/.gitconfig"
export XDG_CONFIG_HOME="${HOME}/.config"

# Aliases
alias cleanup='rm ~/.zsh_history && history -p && touch ~/.zsh_history && exit'

# Starship
if [[ -z ${STARSHIP_SHELL-} ]]; then
  eval "$(starship init zsh)"
fi
