{ config, pkgs, ... }:

{
  systemd.user.services.firefox = {
    description = "Firefox Browser";
    serviceConfig = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/firefox";
      Restart = "always";
      RestartSec = 5;
    };
    wantedBy = [ "default.target" ];
  };

  systemd.services.firefox.enable = true;
}
