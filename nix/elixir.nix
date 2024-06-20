{
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
        name = "elixir_flake";
        src = ./.;

        env = {
          ELIXIR_ERL_OPTIONS = "+fnu";
        };

        nativeBuildInputs = with pkgs; [
          elixir
          curl
          jq
          nodejs
        ];
      };
    };
  };
}
