{ pkgs, ... }:

{
  xdg.configFile = {
    "zsh/.zshrc".text = ''
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
      source "''${ZDOTDIR}/plugins.zsh"
      
      # Don't record duplicates in history
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_SPACE
      setopt HIST_REDUCE_BLANKS
      setopt INC_APPEND_HISTORY
      HISTFILE="''${HOME}/.zsh_history"
      HISTSIZE=1000
      SAVEHIST=1000
      
      # Environment variables
      export CLICOLOR=1
      export DOCKER_DEFAULT_PLATFORM=linux/amd64
      export EDITOR="nvim"
      export GIT_CONFIG_GLOBAL="''${HOME}/.config/git/.gitconfig"
      export VISUAL="nvim"
      export XDG_CONFIG_HOME="''${HOME}/.config"
      export PATH="''${HOME}/.local/bin:''${PATH}"
      
      # Aliases
      alias cleanup='rm ~/.zsh_history && history -p && touch ~/.zsh_history && exit'
      
      # Keychain configuration
      KEYCHAIN="''${HOME}/Library/Keychains/login.keychain-db"
      
      if ! security show-keychain-info "''${KEYCHAIN}" >/dev/null 2>&1; then
        echo "Unlocking agent keychain..."
        security unlock-keychain "''${KEYCHAIN}"
      fi
      
      # Starship
      if [[ -z ''${STARSHIP_SHELL-} ]]; then
        eval "$(starship init zsh)"
      fi
    '';

    "zsh/plugins.zsh".text = ''
      # zsh-autosuggestions configuration
      typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#808080'
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      source ${pkgs.zsh-autosuggestions}/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

      # zsh-vi-mode configuration
      function zvm_config() {
        ZVM_VI_EDITOR=nvim
        ZVM_TERM=xterm-ghostty
        ZVM_CURSOR_STYLE_ENABLED=true
        ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
        ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
        ZVM_SYSTEM_CLIPBOARD_ENABLED=true
        ZVM_CLIPBOARD_COPY_CMD=pbcopy
        ZVM_CLIPBOARD_PASTE_CMD=pbpaste
        ZVM_VI_HIGHLIGHT_BACKGROUND='#707070'
        ZVM_VI_HIGHLIGHT_FOREGROUND='#f0f0f0'
      }

      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
  };
}
