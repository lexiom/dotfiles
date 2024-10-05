{
  description = "Python Development Environment";
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
      default = pkgs.mkShell {
        LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
        nativeBuildInputs = with pkgs; [
          (python3.withPackages (ps: [ps.pynvim]))
          curl
          jq
          pdm
          nodejs_22
        ];
      };
    };
  };
}
