{ config, pkgs, ... }:

{
  services.netdata= {
    enable = true;
    python.enable = true;
    python.extraPackages = ps: [
      ps.docker
      ps.pysensors
    ];
  };
}
