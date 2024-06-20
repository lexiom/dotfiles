{
  description = "Python Environment v0.1";
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
        name = "python_flake";
        src = ./.;

        nativeBuildInputs = with pkgs; [
          (python3.withPackages (ps: [ps.pynvim]))
          pdm
          nodejs
          curl
          jq
        ];
      };
    };
  };
}
