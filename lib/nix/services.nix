{ config, pkgs, ... }:

{
  services.ntp.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    forwardX11 = true;
    passwordAuthentication = false;
  };

  services.journald.extraConfig = ''
    SystemMaxUse=500M
  '';

  services.cron.enable = true;
}
