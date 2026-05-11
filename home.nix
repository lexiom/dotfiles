{ config, inputs, pkgs, ... }:

let
  tree-sitter-odin = pkgs.tree-sitter.buildGrammar {
    language = "odin";
    version = "1.3.0";
    src = inputs.tree-sitter-odin;
  };
in {
  home.username = "sysadmin";
  home.homeDirectory = "/home/sysadmin";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    # Dependencies
    cargo
    fd
    fzf
    gcc
    jq
    lua5_1
    luarocks
    nodejs
    python3
    ripgrep
    unzip

    # Utilities 
    direnv
    nix-direnv
    starship
    tmux
    tree
    zsh-autosuggestions
    zsh-vi-mode

    # LSPs
    bash-language-server
    clang-tools
    lua-language-server
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

    extraPackages = with pkgs.tree-sitter-grammars; [
      tree-sitter-bash
      tree-sitter-c
      tree-sitter-cmake
      tree-sitter-cpp
      tree-sitter-css
      tree-sitter-dockerfile
      tree-sitter-go
      tree-sitter-hcl
      tree-sitter-html
      tree-sitter-json
      tree-sitter-lua
      tree-sitter-markdown
      tree-sitter-markdown-inline
      tree-sitter-nix
      tree-sitter-python
      tree-sitter-rust
      tree-sitter-sql
      tree-sitter-toml
      tree-sitter-typescript
      tree-sitter-vim
      tree-sitter-yaml
      tree-sitter-odin
    ];

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
  
      # zsh-vi-mode configuration
      ZVM_VI_EDITOR=nvim
      # ZVM_TERM=${TERM:-xterm-ghostty}
      ZVM_TERM=xterm-ghostty
      ZVM_CURSOR_STYLE_ENABLED=true
      ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
      ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
      ZVM_SYSTEM_CLIPBOARD_ENABLED=true
  
      source ${pkgs.zsh-autosuggestions}/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
    "zsh/.zshrc".source = ./settings/zsh/zshrc.sh;
  };
}
