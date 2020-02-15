{ config, pkgs, lib, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };
}
