{ pkgs, self, ... }:

{
  environment.systemPackages = with pkgs; [
    ghostty-bin
    wget
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka-term-slab
  ];

  homebrew = {
    enable = true;
    casks = [
      "nikitabobko/tap/aerospace"
      "ungoogled-chromium"
    ];
  };

  networking.hostName = "macos";

  nix = {
    enable = true;
    settings = {
      # Set download buffer to 256MB.
      download-buffer-size = 268435456;
      # Necessary for using flakes on this system.
      experimental-features = "nix-command flakes";
    };
  };

  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.defaults = {
    CustomUserPreferences = {
      # Set Hammerspoon config path to ~/.config/hammerspoon/init.lua.
      "org.hammerspoon.Hammerspoon" = {
        MJConfigFile = "~/.config/hammerspoon/init.lua";
      };
      NSGlobalDomain = {
        # When switching to an application, switch to a Space with open windows for the application.
        AppleSpacesSwitchOnActivate = true;
        # Close windows when quitting an application.
        NSQuitAlwaysKeepsWindows = false;
      };
    };

    dock = {
      # Automatically hide and show the Dock.
      autohide = true;
      # Group windows by application.
      expose-group-apps = true;
      # Icon magnification.
      magnification = false;
      # Minimize window effect.
      mineffect = "scale";
      # Minimize windows into application icon.
      minimize-to-application = false;
      # Automatically rearrange spaces based on most recent use.
      mru-spaces = false;
      # Position on screen.
      orientation = "bottom";
      # Applications pinned to the Dock.
      persistent-apps = [
        "/System/Applications/Launchpad.app"
      ];
      # Other items pinned to the Dock.
      persistent-others = [];
      # Show indicators for open applications.
      show-process-indicators = true;
      # Show suggested and recent apps in Dock.
      show-recents = false;
      # Dock size.
      tilesize = 56;
      # Hot corner actions (1: disabled).
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
    };

    spaces = {
      # Displays have separate Spaces.
      spans-displays = false;
    };

    WindowManager = {
      # Show desktop items on desktop.
      EnableStandardClickToShowDesktop = false;
      # Tiled windows have margins.
      EnableTiledWindowMargins = false;
      # Drag windows to screen edges to tile.
      EnableTilingByEdgeDrag = false;
      # Drag windows to menu bar to fill screen.
      EnableTopTilingByEdgeDrag = false;
      # Enable Stage Manager.
      GloballyEnabled = false;
      # Show desktop items in Stage Manager.
      StageManagerHideWidgets = false;
      # Show desktop items on desktop.
      StandardHideDesktopIcons = false;
    };
  };

  # System's default user.
  system.primaryUser = "alexandre";

  # For backwards compatibility, check the changelog before changing (darwin-rebuild changelog)
  system.stateVersion = 6;

  users.users.alexandre = {
    home = "/Users/alexandre";
  };
}
