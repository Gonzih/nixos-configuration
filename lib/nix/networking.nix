{ config, pkgs, ... }:

{
  networking = {
    # Open ports in the firewall.
    firewall.allowedTCPPorts = [ 22 9100 19999 8080 4200 1337 ];
    # firewall.allowedUDPPorts = [ ... ];
    firewall.allowedTCPPortRanges = [ ];
    firewall.allowedUDPPortRanges = [
      { from = 60000; to = 61000; }
    ];
    # Or disable the firewall altogether.
    # firewall.enable = false;

    # nameservers = [  "192.168.2.100" "1.1.1.1" ];
    enableIPv6 = false;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
