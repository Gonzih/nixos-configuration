{ config, pkgs, ... }:

{
  systemd.user.services.slack = {
    description = "Slack";
    environment = {
      SLACK_DEVELOPER_MENU = "true";
    };
    serviceConfig = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/slack";
      Restart = "always";
      RestartSec = 15;
    };
    wantedBy = [ "default.target" ];
  };

  systemd.services.slack.enable = true;
}
