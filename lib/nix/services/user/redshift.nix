{ config, pkgs, ... }:

{
  systemd.user.services.redshift = {
    description = "Redshift";
    serviceConfig = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/redshift -t 5500:2200 -l 43.648723:-79.357716";
      Restart = "on-failure";
      RestartSec = 15;
    };
    wantedBy = [ "default.target" ];
  };

  systemd.services.redshift.enable = true;
}
