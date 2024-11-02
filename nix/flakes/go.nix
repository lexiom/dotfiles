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
      default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          delve
          go
          go-outline
          go-tools
          gopkgs
          gopls
        ];
      };
    };
  };
}
