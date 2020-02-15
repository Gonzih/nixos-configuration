{ config, pkgs, lib, ... }:

let
  secrets = import ./../../../secrets.nix;
in
{
  users.groups.samba = {
    name = "samba";
    members = [ "samba" ];
  };

  users.users.samba = {
    isNormalUser = false;
    home = "/home/samba";
    group = "samba";
    createHome = false;
    description = "Samba User";
    hashedPassword = secrets.users.samba.hashedPassword;
  };
}
