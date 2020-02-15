{ config, pkgs, ... }:

{
  users.users.octoprint = {
    extraGroups = [ "dialout" ];
  };
  services.octoprint = {
    enable = true;
    port = 4200;
  };
}
