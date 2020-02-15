{ config, pkgs, lib, ... }:

{
  services.kubernetes = {
    roles = [ "node" ];
    masterAddress = "nas";
  };
}
