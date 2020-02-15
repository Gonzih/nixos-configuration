{ config, pkgs, ... }:

{
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    ## supported in 19+
    ## Not needed for now
    # extraModules = [ pkgs.pulseaudio-modules-bt ];

    # NixOS allows either a lightweight build (default) or full build of PulseAudio to be installed.
    # Only the full build has Bluetooth support, so it must be selected here.
    package = pkgs.pulseaudioFull;
    extraConfig  = ''
      load-module module-equalizer-sink
      load-module module-dbus-protocol
      load-module module-switch-on-connect
    '';
  };

  # Enable bluetooth for my fance headset
  hardware.bluetooth.enable = true;
}
