{ config, pkgs, ... }:

{
  systemd.user.services.discord = {
    description = "Discord";
    serviceConfig = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/Discord";
      Restart = "always";
      RestartSec = 15;
    };
    wantedBy = [ "default.target" ];
  };

  systemd.services.discord.enable = true;
}
