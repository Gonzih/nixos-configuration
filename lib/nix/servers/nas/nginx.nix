{ config, pkgs, lib, ... }:

{
  services.nginx.enable = true;
  services.nginx.virtualHosts."notes.gonzih.me" = {
    addSSL = true;
    enableACME = true;
    root = "/var/www/notes";
  };
  services.nginx.virtualHosts."grafana.gonzih.me" = {
    addSSL = true;
    enableACME = true;
    locations."/".proxyPass = "http://127.0.0.1:3000/";
  };
  services.nginx.virtualHosts."pihole.gonzih.me" = {
    addSSL = true;
    enableACME = true;
    locations."/".proxyPass = "http://127.0.0.1:3030/admin/";
  };

  security.acme.certs = {
    "notes.gonzih.me".email = "gonzih@gmail.com";
    "grafana.gonzih.me".email = "gonzih@gmail.com";
    "pihole.gonzih.me".email = "gonzih@gmail.com";
  };
}
