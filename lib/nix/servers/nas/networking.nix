{ config, pkgs, lib, ... }:

{
  networking = {
    # Open ports for SAMBA
    firewall.allowedTCPPorts = [ 22 53 80 139 443 445 3000 8080 19999 ];
    firewall.allowedUDPPorts = [ 53 67 137 138 ];

    # Copy network config
    firewall.allowedTCPPortRanges = [
    ];
    firewall.allowedUDPPortRanges = [
      { from = 60000; to = 61000; }
    ];

    enableIPv6 = false;
  };
}
