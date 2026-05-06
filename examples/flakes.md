# flakes

## Basic C flake

```nix
{
  description = "C development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          clang
          clang-tools
          lldb
          pkg-config
          gnumake
        ];
      };
    };
}
```
