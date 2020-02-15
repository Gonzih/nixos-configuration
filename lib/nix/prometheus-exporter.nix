{ config, pkgs, lib, ... }:


{
  services.prometheus.exporters.node.enable = true;
}
