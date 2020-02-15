{ config, pkgs, ... }:

{
  systemd.user.services.telegram = {
    description = "Telegram";
    serviceConfig = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/telegram-desktop";
      Restart = "always";
      RestartSec = 15;
    };
    wantedBy = [ "default.target" ];
  };

  systemd.services.telegram.enable = true;
}
