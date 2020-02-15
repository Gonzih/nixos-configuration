{ config, pkgs, lib, ... }:

let
  secrets = import ./../../../secrets.nix;
in
{
  services.grafana= {
    enable = true;
    security.adminPassword =  secrets.grafana.password;
    port = 3000;
    addr = "0.0.0.0";
  };
}
