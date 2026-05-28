{ config, pkgs, ... }:

{
  networking.interfaces.ens18.ipv4.addresses = [
    {
      address = "10.0.0.22";
      prefixLength = 24;
    }
  ];

  services.openssh.settings = {
    KbdInteractiveAuthentication = false;
    PasswordAuthentication = false;
    PermitRootLogin = "no";
  };

  users.users.sysadmin.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEP3Hjjx4QPZdJOe8FS3S5oPYG8M08FCNrKNanhZuBjq id@work"
  ];

  home-manager.users.sysadmin = {
    home.packages = with pkgs; [
      # Tools
      cargo
      duckdb
      gcc
      gh
      go
      google-cloud-sdk
      k9s
      kubectl
      nodejs
      python3
      tenv
      uv

      # LSPs
      bash-language-server
      dockerfile-language-server
      ruff
      terraform-ls
      ty
      vscode-langservers-extracted # JSON
      yaml-language-server
    ];
  };
}
