{ config, pkgs, ... }:

{
  boot.extraModulePackages = with config.boot.kernelPackages; [
    wireguard
    # it87
  ];
}
