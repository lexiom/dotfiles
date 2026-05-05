{
  description = "NixOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-25.11";
    };
    tree-sitter-odin = {
      url = "github:tree-sitter-grammars/tree-sitter-odin/v1.3.0";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    mkHost = { vmHardware, vmModule, vmName }:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs vmName;
        };

        modules = [
          ./configuration.nix
          vmHardware
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager.users.sysadmin = import ./home.nix;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
          vmModule
        ];
      };
  in {
    nixosConfigurations = {
      base = mkHost {
        vmHardware = ./hardware/base.nix;
        vmModule = ./modules/base.nix;
        vmName = "base";
      };
      personal = mkHost {
        vmHardware = ./hardware/personal.nix;
        vmModule = ./modules/personal.nix;
        vmName = "personal";
      };
      work = mkHost {
        vmHardware = ./hardware/work.nix;
        vmModule = ./modules/work.nix;
        vmName = "work";
      };
    };
  };
}
