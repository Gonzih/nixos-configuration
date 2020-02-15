{ config, pkgs, ... }:

let
  secrets = import ./../../../../secrets.nix;
in
{
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.200.200.3/32" ];
      dns = [ "10.200.200.1" ];

      privateKey = "${secrets.wireguard.clients.y700.privateKey}";

      peers = [
        {
          publicKey = "${secrets.wireguard.servers.nas.publicKey}";

          allowedIPs = [ "0.0.0.0/0" ];
          # Or forward only particular subnets
          #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

          # Set this to the server IP and port.
          endpoint = secrets.wireguard.servers.nas.endpoint;
        }
      ];
    };
  };
}
