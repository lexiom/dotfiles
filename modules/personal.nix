{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pciutils
    usbutils

    openocd
    stlink

    minicom
    picocom
    screen
  ];

  networking.interfaces.ens18.ipv4.addresses = [
    {
      address = "10.0.0.21";
      prefixLength = 24;
    }
  ];

  services.openssh.settings = {
    KbdInteractiveAuthentication = false;
    PasswordAuthentication = false;
    PermitRootLogin = "no";
  };

  services.udev.extraRules = ''
    # ST-LINK/V2
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="0666", GROUP="plugdev", TAG+="uaccess"

    # ST-LINK/V2.1 variants
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374b", MODE="0666", GROUP="plugdev", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3752", MODE="0666", GROUP="plugdev", TAG+="uaccess"

    # STLINK-V3 variants
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374d", MODE="0666", GROUP="plugdev", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374e", MODE="0666", GROUP="plugdev", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374f", MODE="0666", GROUP="plugdev", TAG+="uaccess"

    # STM32 DFU mode, useful later
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="df11", MODE="0666", GROUP="plugdev", TAG+="uaccess"
  '';

  services.udev.packages = with pkgs; [
    stlink
    openocd
  ];

  users.users.sysadmin.extraGroups = [
    "dialout"
    "plugdev"
  ];

  users.users.sysadmin.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgxW38sB9XvEiO3Mz0CEnyRdhexhbyHz68yHuVrxWV+ id@personal"
  ];

  home-manager.users.sysadmin = {
    home.packages = with pkgs; [
      bear
      gcc-arm-embedded
      gnumake
      pkg-config

      sigrok-cli
      pulseview

      odin
      ols
    ];
  };
}
