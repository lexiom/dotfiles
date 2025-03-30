# Number of commands to remember in memory
HISTSIZE=3000

# Number of commands to save to ~/.zsh_history
SAVEHIST=3000

# Append each command to history instead of writing them all at once on shell exit
setopt APPEND_HISTORY

# Delete old duplicates when a new command is entered
setopt HIST_IGNORE_ALL_DUPS

# Don't write duplicate entries to ~/.zsh_history
setopt HIST_SAVE_NO_DUPS

# Remove superfluous blanks before recording
setopt HIST_REDUCE_BLANKS

# Share history across all sessions
setopt SHARE_HISTORY

# Plugins for zsh
source $(brew --prefix)/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Output colors for the `ls` command
export CLICOLOR=1

# Starship
eval "$(starship init zsh)"

# Completions
FPATH="$HOME/.docker/completions:$FPATH"
autoload -Uz compinit
compinit
