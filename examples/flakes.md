# flakes

## Basic C/C++ flake

```nix
{
  description = "C/C++ development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          # Keep clang-tools before clang so clangd resolves correctly
          clang-tools
          clang

          # Build and debug
          gnumake
          lldb
          pkg-config

          # Other dependencies
          lua
          SDL2
          SDL2_image
          SDL2_mixer
          SDL2_ttf
        ];
      };
    };
}
```

## Basic Odin flake

```nix
{
  description = "Odin development environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  # Overriding LLVM Nixpkgs version to match what Odin currently needs
  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      overlays = [
        (final: prev: {
          odin = prev.odin.override {
            llvmPackages_18 = prev.llvmPackages_21;
          };
        })
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
      };
      llvm = pkgs.llvmPackages_21;
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.odin
          pkgs.raylib

          llvm.clang
          llvm.lldb
          llvm.bintools
        ];
      };
    };
}
```
