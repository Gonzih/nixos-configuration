{ config, pkgs, ... }:

let
  secrets = import ./../../../secrets.nix;
  externalInterface = "enp2s0";
  internalInterface = "wg0";
  externalPort = 5182;
  externalNetMask = "10.200.200.1/24";
in
{
  # enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = externalInterface;
  networking.nat.internalInterfaces = [ internalInterface ];
  networking.firewall = {
    allowedUDPPorts = [ externalPort ];
  };

  networking.wireguard.interfaces = {
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ externalNetMask ];

      # The port that Wireguard listens to. Must be accessible by the client.
      listenPort = externalPort;

      privateKey = "${secrets.wireguard.servers.nas.privateKey}";

      # Disabling net mask here for now
      # postSetup = ''
      #   iptables -A FORWARD -i wg0 -j ACCEPT
      #   iptables -t nat -A POSTROUTING -s ${externalNetMask} -o ${externalInterface} -j MASQUERADE
      # '';

      postSetup = ''
        /run/current-system/sw/bin/iptables -A FORWARD -i ${internalInterface} -j ACCEPT
        /run/current-system/sw/bin/iptables -A FORWARD -o ${internalInterface} -j ACCEPT
        /run/current-system/sw/bin/iptables -t nat -A POSTROUTING -o ${externalInterface} -j MASQUERADE
      '';

      postShutdown = ''
        /run/current-system/sw/bin/iptables -D FORWARD -i ${internalInterface} -j ACCEPT
        /run/current-system/sw/bin/iptables -D FORWARD -o ${internalInterface} -j ACCEPT
        /run/current-system/sw/bin/iptables -t nat -D POSTROUTING -o ${externalInterface} -j MASQUERADE
      '';

      peers = [
        # zte blade
        {
          publicKey = "${secrets.wireguard.clients.zteBlade.publicKey}";
          allowedIPs = [ "10.200.200.2/32" ];
        }
        # y700 lappy
        {
          publicKey = "${secrets.wireguard.clients.y700.publicKey}";
          allowedIPs = [ "10.200.200.3/32" ];
        }
        # wifu iphone
        {
          publicKey = "${secrets.wireguard.clients.wifuIphone.publicKey}";
          allowedIPs = [ "10.200.200.4/32" ];
        }
        # x230
        {
          publicKey = "${secrets.wireguard.clients.x230.publicKey}";
          allowedIPs = [ "10.200.200.5/32" ];
        }
      ];
    };
  };
}
