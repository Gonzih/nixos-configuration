{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    ( import ./pkgs.nix )
    ( import ./prusa-slicer.nix )
  ];
}
