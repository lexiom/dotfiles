{ config, pkgs, vmName, ... }:

{
  # LVM support.
  boot.initrd.services.lvm.enable = true;

  # Set kernel version.
  boot.kernelPackages = pkgs.linuxPackages_6_18;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set system packages.
  environment.systemPackages = with pkgs; [
    curl
    git
    lvm2
    neovim
    wget
  ];

  # Set system environment variables.
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";
  };

  # Define your hostname.
  networking.hostName = vmName;

  # Setting up network.
  networking.defaultGateway = "10.0.0.1";
  networking.nameservers = [
    "10.0.0.1"
  ];

  # Disable DHCP.
  networking.useDHCP = false;

  # Enable Nix Flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable ZSH.
  programs.zsh.enable = true;

  # Enable password feedback.
  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable QEMU Guest Agent.
  services.qemuGuest.enable = true;

  # Pin NixOS version.
  system.stateVersion = "25.11";

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Define a user account.
  users.users.sysadmin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
}
