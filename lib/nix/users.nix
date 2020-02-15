let secrets = import ./../secrets.nix; in

{ config, pkgs, ... }:

{
  # DO NOT SET THIS TO FALSE ON RUNNING SYSTEM
  # will mess everything up
  users.mutableUsers = true;
  users.users.root.hashedPassword = secrets.users.root.hashedPassword;
}
