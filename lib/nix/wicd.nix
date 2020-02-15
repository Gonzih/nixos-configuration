{ config, pkgs, ... }:

{
  networking = {
    useDHCP = false; # Don't run dhclient on wlan0
    wireless.enable = false;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = false; # Enable networkmanager or not
    wicd.enable = true; # Enable wicd or not
  };
}
