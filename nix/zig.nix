{
  description = "Zig Development Environment";
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
        name = "zig_flake";
        nativeBuildInputs = with pkgs; [
          zig
        ];
        src = ./.;
      };
    };
  };
}
