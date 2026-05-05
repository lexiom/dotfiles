{ config, pkgs, ... }:

{
  networking.interfaces.ens18.ipv4.addresses = [
    {
      address = "10.0.0.20";
      prefixLength = 24;
    }
  ];

  services.openssh.settings = {
    KbdInteractiveAuthentication = true;
    PasswordAuthentication = true;
    PermitRootLogin = "no";
  };
}
