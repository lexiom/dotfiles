{
  description = "Rust Environment";
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
        name = "rust_flake";
        nativeBuildInputs = with pkgs; [
          cargo
          curl
          jq
          rustc
        ];
        src = ./.;
      };
    };
  };
}
