{ config, pkgs, ... }:

{
  systemd.user.services.thunderbird = {
    description = "Thunderbird";
    serviceConfig = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/thunderbird";
      Restart = "always";
      RestartSec = 15;
    };
    path = [
      pkgs.gnupg
      pkgs.thunderbird
    ];
    wantedBy = [ "default.target" ];
  };

  systemd.services.thunderbird.enable = true;
}
