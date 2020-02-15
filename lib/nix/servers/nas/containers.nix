{ config, pkgs, lib, ... }:

let
  secrets = import ./../../../secrets.nix;
in
{
  docker-containers = {
    pihole = {
      image = "pihole/pihole:4.3.2-1";
      environment = {
        ServerIP = "69.158.71.90";
        WEBPASSWORD = secrets.pihole.password;
      };
      ports = [
        "53:53/tcp"
        "53:53/udp"
        "67:67/udp"
        "3030:80"
        "3443:443"
      ];
      volumes = [
        "/var/run/pihole/:/etc/pihole/"
        "/var/run/pihole/dnsqmasq.d:/etc/pihole/dnsmasq.d/"
      ];
      extraDockerOptions = [
        "--cap-add=NET_ADMIN"
      ];
    };

    pihole-exporter = {
      image = "ekofr/pihole-exporter:latest";
      environment = {
        PIHOLE_HOSTNAME = "192.168.2.100";
        PIHOLE_PASSWORD = secrets.pihole.password;
        INTERVAL = "15s";
        PORT = "9617";
      };
      ports = [
        "9617:9617"
      ];
    };
  };
}
