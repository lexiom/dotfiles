{ inputs, pkgs, ... }:

{
  home.username = "alexandre";
  home.homeDirectory = "/Users/alexandre";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    # Basic Dependencies
    fd
    fzf
    git
    ripgrep
    tree-sitter

    # Common Utilities
    dos2unix
    ipcalc
    jq
    lima-full
    starship
    tmux
    tree
    yq

    # Container Tools
    colima
    docker-buildx
    docker-client
    docker-credential-helpers

    # Extensions & Plug-ins
    shellcheck
    shfmt
    zsh-autosuggestions
    zsh-vi-mode

    # Work Specific
    actionlint
    gh
    google-cloud-sdk
    tenv
  ];

  home.file = {
    ".hushlogin" = { text = ""; };
    ".ssh/config".source = ./settings/ssh/config;
    ".tmux.conf".source = ./settings/tmux/tmux.conf;
    ".zshenv".source = ./settings/zsh/zshenv.sh;
  };

  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    config = {
      global = {
        warn_timeout = "30s";
      };
    };
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
      eval "$(direnv hook zsh)"
    '';
  };
}
