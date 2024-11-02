# xdelta -d -s original_file xdelta_file output_file
# cmp --silent $old $new || echo "files are different"
{
  description = "Xdelta Development Environment";
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
            xdelta
        ];
      };
    };
  };
}
