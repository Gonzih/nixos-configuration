{ config, pkgs, lib, ... }:

{
  networking.extraHosts =
  ''
    192.168.2.100 nas
  '';
}
