{
  description = "C++ Development Environment";
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
      default = pkgs.mkShell.override { stdenv = pkgs.clangStdenv; } {
        CMAKE_EXPORT_COMPILE_COMMANDS = 1;
        LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
        nativeBuildInputs = with pkgs; [
          # Build deps
          clang
          lerc.dev
          libdatrie.dev
          libepoxy.dev
          libselinux.dev
          libsepol.dev
          libsysprof-capture
          libthai.dev
          libuuid.dev
          libxkbcommon.dev
          pcre2.dev
          sqlite.dev
          xorg.libXdmcp.dev
          xorg.libXtst

          # Build tools
          cmake
          pkg-config
        ];
      };
    };
  };
}

