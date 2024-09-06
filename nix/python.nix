{
  description = "Python Environment";
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
        nativeBuildInputs = with pkgs; [
          (python3.withPackages (ps: [ps.pynvim]))
          curl
          jq
          nodejs_22
          pdm
        ];
        src = ./.;
      };
    };
  };
}
