{
  description = "macOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-darwin/nix-darwin/master";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    tree-sitter-odin = {
      url = "github:tree-sitter-grammars/tree-sitter-odin/v1.3.0";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, home-manager, ... }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#macos
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self inputs; };
      modules = [
        ./configuration.nix

        home-manager.darwinModules.home-manager

        {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.hostPlatform = "aarch64-darwin";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
          home-manager.users.alexandre = import ./home.nix;
        }
      ];
    };
  };
}
