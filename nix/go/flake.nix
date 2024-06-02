{
  description = "Go Development Environment";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
  }: {
    packages."x86_64-linux" = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in {
      default = pkgs.stdenv.mkDerivation {
        name = "go_flake";
        src = ./.;

        nativeBuildInputs = with pkgs; [
          go
          go-outline
          gopls
          gopkgs
          go-tools
          delve
        ];
      };
    };
  };
}
