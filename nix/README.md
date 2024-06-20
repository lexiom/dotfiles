# local development environment using nix flakes

- Before doing anything, don´t forget to rename the file you wish to run to `flake.nix`
- Then, you can run the following command `nix develop`
- You can find a basic example of a nix flake below:

```nix
{
  description = "Hello, Nix Flakes!";
  # inputs is where we define the origin of our packages/code
  # e.g., from GitHub, locally, or some place else
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };
  # outputs is the function where we define how the packages/code will be processed
  # the self argument is used to reference this particular flake and/or its source
  # the nixpkgs argument means that we are working with a local copy of this object, which
  # was downloaded to our machine (nix/store) after we specified it in the 'inputs' section
  outputs = {
    self,
    nixpkgs,
  }: {
    # let & in are the places where we define local variables
    # import the nixpkgs object specified in the function's arguments
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
        # buildInputs is for dependencies that should exist in both build and runtime envs
        buildInputs = with pkgs; [
          curl
          jq
        ];
      };
    };
  };
}
```
