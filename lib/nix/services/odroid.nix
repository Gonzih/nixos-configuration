{ config, pkgs, ... }:

{
  systemd.services.odroid = {
    description = "Odroid Screen";
    serviceConfig = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/odroid-status-screen-go";
      Restart = "always";
      RestartSec = 15;
    };
    path = [
      pkgs.bash
      pkgs.which
      pkgs.linuxPackages_latest.nvidia_x11
      pkgs.nvme-cli
    ];
    wantedBy = [ "default.target" ];
  };

  systemd.services.odroid.enable = true;
}
