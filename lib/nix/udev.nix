{ config, pkgs, ... }:

{
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff4", MODE:="0666"
  '';
}
