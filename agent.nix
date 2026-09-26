{ config, inputs, pkgs, ... }:

{
  home.username = "agent";
  home.homeDirectory = "/Users/agent";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    # Basic Dependencies
    fd
    fzf
    git
    ripgrep
    tree-sitter

    # Common Utilities
    jq
    starship
    yq

    # Container Tools
    colima
    docker-buildx
    docker-client
    docker-credential-helpers

    # Extensions & Plug-ins
    zsh-autosuggestions
    zsh-vi-mode

    # Work Specific
    actionlint
    # cursor-cli # old
    gh
    google-cloud-sdk
    tenv
  ];

  home.file = {
    ".hushlogin" = { text = ""; };
    ".zshenv".source = ./settings/zsh/zshenv.sh;
  };

  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile = {
    "nvim" = {
      recursive = true;
      source = ./settings/agent/nvim;
    };
    "starship.toml".source = ./settings/starship/starship.toml;
    "zsh/.zshrc".source = ./settings/agent/zsh/zshrc.sh;
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
