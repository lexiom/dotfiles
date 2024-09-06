{
  description = "Neovim Build Environment";
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
        name = "nvim_flake";
        nativeBuildInputs = with pkgs; [
          (python3.withPackages (ps: [ps.pynvim]))
          cargo
          curl
          jq
          nodejs_22
          rustc
        ];
        src = ./.;
      };
    };
  };
}
