{ config, inputs, pkgs, ... }:

{
  home.username = "sysadm";
  home.homeDirectory = "/home/sysadm";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    # Dependencies
    fd
    fzf
    jq
    ripgrep
    unzip
    wl-clipboard
    zip

    # Utilities 
    direnv
    nix-direnv
    starship
    tmux
    tree
    zsh-autosuggestions
    zsh-vi-mode
  ];

  home.file = {
    ".hushlogin" = { text = ""; };
    ".ssh/config".source = ./settings/ssh/config;
    ".ssh/id_personal.pub".source = ./settings/ssh/id_personal.pub;
    ".ssh/id_work.pub".source = ./settings/ssh/id_work.pub;
    ".tmux.conf".source = ./settings/tmux/tmux.conf;
    ".zshenv".source = ./settings/zsh/zshenv.sh;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = true;
    viAlias = true;
    vimAlias = true;

    extraPython3Packages = ps: with ps; [
      pynvim
    ];
  };

  xdg.configFile = {
    "nvim" = {
      recursive = true;
      source = ./settings/nvim;
    };
    "starship.toml".source = ./settings/starship/starship.toml;
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
        ZVM_CLIPBOARD_COPY_CMD=wl-copy
        ZVM_CLIPBOARD_PASTE_CMD=wl-paste
      }

      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      eval "$(direnv hook zsh)"
    '';
    "zsh/.zshrc".source = ./settings/zsh/zshrc.sh;
  };
}
