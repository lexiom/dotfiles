{
  description = "Embedded Development Environment";
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
      default = pkgs.mkShell.override { stdenv = pkgs.stdenvNoCC; } {
        nativeBuildInputs = with pkgs; [
          # Core
          gcc-arm-embedded-13
          libusb1
          stlink

          # Development
          bear
          # clang-tools # 64-bit
          pkgsi686Linux.clang-tools # 32-bit
        ];

        # shellHook = ''
        #   alias gcc-arm=arm-none-eabi-gcc
        # '';
      };
    };
  };
}
