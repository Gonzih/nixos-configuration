let secrets = import ./../secrets.nix; in

{ config, pkgs, ... }:

{
  users.groups.gnzh = {
    name = "gnzh";
    members = [ "gnzh" ];
  };
  users.users.gnzh = {
    shell = "/run/current-system/sw/bin/fish";
    isNormalUser = true;
    home = "/home/gnzh";
    group = "gnzh";
    createHome = true;
    description = "Max Gonzih";
    extraGroups = [ "wheel" "networkmanager" "audio" "dialout" "docker" "disk" ];
    hashedPassword = secrets.users.gnzh.hashedPassword;
    uid = 1000;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCQL3+yA0fcuiviQEBkugGr2WauKfre1g5/ubOMyc9N78lVsvHMIVpzqDIQmeIX+03tHJUjlAr+BTdySCo0jscPdO6qvk8zCO+Fwnv4Lr0DU9t+6iOSnBdB9GJ2Oa3bD0QyA/3szUh66nc/P0boOvDKHKmpUL42uac1ah9LvcDWH1u0p0KQZTpONQMGd8jMFYdOQGNucrsiwEZuWldghQDwhSngKo1C3jmZgd00vgbmJb9EMFnfos9cH0KmSbaZ5EAYZkHHLVXPl/Df2C0C5VJcdvdbIiG/ZNH59dCeqfX0tcRJp6zVLlEalc0116kI3whfqES/haGrxJiKyaZveMN1 openpgp:0x1D5AE9BA"
    ];
  };
}
