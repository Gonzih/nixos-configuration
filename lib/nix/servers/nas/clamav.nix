{ config, pkgs, lib, ... }:

{
  services.clamav.daemon.enable = true;
  services.clamav.daemon.extraConfig = ''
  '';
  services.clamav.updater.enable = true;
}
