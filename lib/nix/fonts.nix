{ config, pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    corefonts
    victor-mono
  ];

  fonts.fontconfig.defaultFonts.monospace = [ "Iosevka Term" ];
}
