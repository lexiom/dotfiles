{ inputs, pkgs, ... }:

{
  home.username = "alexandre";
  home.homeDirectory = "/Users/alexandre";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    # Dependencies
    fd
    fzf
    jq
    ripgrep

    # Utilities
    direnv
    nix-direnv
    starship
    tmux
    tree
    wakeonlan
    zsh-autosuggestions
    zsh-vi-mode

    # Apps
    keepassxc
    monitorcontrol
  ];

  home.file = {
    ".hushlogin" = { text = ""; };
    ".ssh/config".source = ./settings/ssh/config;
    ".tmux.conf".source = ./settings/tmux/tmux.conf;
    ".zshenv".source = ./settings/zsh/zshenv.sh;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile = {
    "aerospace" = {
      recursive = true;
      source = ./settings/aerospace;
    };
    "ghostty" = {
      recursive = true;
      source = ./settings/ghostty;
    };
    "nvim" = {
      recursive = true;
      source = ./settings/nvim;
    };
    "starship.toml".source = ./settings/starship/starship.toml;
    "zsh/.zprofile".source = ./settings/zsh/zprofile.sh;
    "zsh/.zshrc".source = ./settings/zsh/zshrc.sh;
    "zsh/plugins.zsh".text = ''
      # zsh-autosuggestions configuration
      typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999999'
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
      }

      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      eval "$(direnv hook zsh)"
    '';
  };
}
