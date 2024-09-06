{
  description = "Elixir Development Environment";
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
        env = {
          ELIXIR_ERL_OPTIONS = "+fnu";
        };
        name = "elixir_flake";
        nativeBuildInputs = with pkgs; [
          curl
          elixir
          jq
          nodejs_22
        ];
        src = ./.;
      };
    };
  };
}
