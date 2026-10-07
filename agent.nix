{ config, inputs, pkgs, ... }:

{
  imports = [
    ./settings/extra/neovim.nix
    ./settings/extra/zsh.nix
  ];

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
      source = ./settings/nvim;
    };
    "starship.toml".source = ./settings/starship/starship.toml;
  };
}
