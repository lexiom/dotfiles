{ config, pkgs, ... }:

{
  # environment.systemPackages = with pkgs; [
  #   openocd
  #   minicom
  #   picocom
  #   screen
  # ];

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

  # services.udev.extraRules = ''
  #   # ST-Link/V2
  #   SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="0666", GROUP="plugdev"
  # '';

  # users.users.sysadmin.extraGroups = [
  #   "plugdev"
  # ];

  users.users.sysadmin.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgxW38sB9XvEiO3Mz0CEnyRdhexhbyHz68yHuVrxWV+ id@personal"
  ];

  home-manager.users.sysadmin = {
    home.packages = with pkgs; [
      odin
      ols
    ];
  };
}
