{ config, pkgs, ... }:

{
  networking = {
    useDHCP = false; # Don't run dhclient on wlan0
    wireless.enable = false;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Enable networkmanager or not
    wicd.enable = false; # Enable wicd or not
  };
}
