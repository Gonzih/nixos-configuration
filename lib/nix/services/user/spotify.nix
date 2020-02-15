{ config, pkgs, ... }:

{
  systemd.user.services.spotify = {
    description = "Spotify player";
    serviceConfig = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/spotify";
      Restart = "always";
      RestartSec = 15;
    };
    wantedBy = [ "default.target" ];
  };

  systemd.services.spotify.enable = true;
}
