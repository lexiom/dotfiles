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
        ELIXIR_ERL_OPTIONS = "+fnu";
        nativeBuildInputs = with pkgs; [
          curl
          elixir
          jq
          nodejs_22
        ];
      };
    };
  };
}
