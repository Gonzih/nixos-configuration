{ config, pkgs, ... }:

{
  systemd.user.services.imwheel = {
    description = "Mouse wheel configuration daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/imwheel -d";
      Restart = "always";
      RestartSec = 15;
    };
    wantedBy = [ "default.target" ];
  };

  systemd.services.imwheel.enable = true;
}
