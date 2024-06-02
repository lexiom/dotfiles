{
  description = "Hello, Nix Flakes!";
  # inputs is where we define the origin of our packages/code
  # e.g., from GitHub, locally, or some place else
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };
  # outputs is where we define how the packages/code will be processed
  # the self argument is used to reference this particular flake and/or its source
  # the nixpkgs argument means that we are working with a local copy of this object, which
  # was downloaded to our machine (nix/store) after we specified it in the 'inputs' section
  outputs = {
    self,
    nixpkgs,
  }: {
    # let & in are sections where we define local variables
    # we import the nixpkgs object (which we got from the function's arguments)
    packages."x86_64-linux" = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in {
      default = pkgs.stdenv.mkDerivation {
        name = "example_flake";
        src = ./.;
        # nativeBuildInputs is for dependencies that should only exist in the build env
        nativeBuildInputs = with pkgs; [
          (python3.withPackages (ps: [ps.pynvim]))
          pdm
          nodejs
        ];
        # buildInputs is for dependencies that should exist in the runtime env
        buildInputs = with pkgs; [
          curl
          jq
        ];
      };
    };
  };
}
