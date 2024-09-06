{
  description = "JUCE Development Environment";
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
        env = {
          CMAKE_EXPORT_COMPILE_COMMANDS = 1;
        };
        name = "juce_flake";
        nativeBuildInputs = with pkgs; [
          # JUCE deps
          alsa-lib.dev
          curl.dev
          fontconfig.dev
          freetype.dev
          jack2.dev
          ladspa-sdk
          libGLU.dev
          mesa.dev
          webkitgtk.dev
          xorg.libX11.dev
          xorg.libXcomposite.dev
          xorg.libXcursor.dev
          xorg.libXext.dev
          xorg.libXinerama.dev
          xorg.libXrandr.dev
          xorg.libXrender.dev

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
        src = ./.;
      };
    };
  };
}

