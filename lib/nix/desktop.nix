{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us(dvp)";
  services.xserver.xkbOptions = "grp:lctrl_toggle,ctrl:nocaps";

  # Enable touchpad support.
  services.xserver.libinput.enable = false;
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = "breeze";
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;

  services.xserver.deviceSection = ''
    Option "TearFree" "true"
    Option "DRI" "2"
  '';

  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];

  # Enable smart cards daemon
  services.pcscd.enable = true;
}
