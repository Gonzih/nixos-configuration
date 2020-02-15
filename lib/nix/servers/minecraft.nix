{ config, pkgs, lib, ... }:

{
  services.minecraft-server = {
    eula = true;
    enable = true;
    openFirewall = true;
    declarative = true;
    jvmOpts = "-Xmx1G -Xms1G -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -XX:-UseAdaptiveSizePolicy";

    whitelist = {
      MaxGonzih = "097e4efa-c81f-4225-8026-e74efa5c93b3";
      LoveTheEvil = "5a775646-e63a-4aa5-b81f-1ceee7594a24";
    };

    serverProperties = {
      server-port = 25565;
      motd = "NixOS powered minecraft";
    };

    package = pkgs.minecraft-server-latest;
  };
}
