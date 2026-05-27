{ inputs, pkgs, ... }:

{
  home.username = "alexandre";
  home.homeDirectory = "/Users/alexandre";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    # Dependencies
    fd
    fzf
    git
    jq
    ripgrep

    # Utilities
    direnv
    nix-direnv
    starship
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
    ".zshenv".source = ./settings/zsh/zshenv.sh;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile = {
    "ghostty" = {
      recursive = true;
      source = ./settings/ghostty;
    };
    "hammerspoon/init.lua".source = ./settings/hammerspoon/init.lua;
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

      # zsh-vi-mode configuration
      ZVM_VI_EDITOR=nvim
      ZVM_TERM=${TERM:-xterm-ghostty}
      ZVM_CURSOR_STYLE_ENABLED=false
      ZVM_SYSTEM_CLIPBOARD_ENABLED=true
      ZVM_CLIPBOARD_COPY_CMD=pbcopy
      ZVM_CLIPBOARD_PASTE_CMD=pbpaste

      source ${pkgs.zsh-autosuggestions}/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
  };
}
