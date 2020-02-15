# Development specific nix configuration

{ config, pkgs, ... }:

{
  services.postgresql.enable = false;
}
