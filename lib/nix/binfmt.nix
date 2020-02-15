{ config, pkgs, ... }:

{
  boot.binfmt.registrations = {
    # $ echo ':golang:E::go::/usr/local/bin/gorun:OC' | sudo tee /proc/sys/fs/binfmt_misc/register
    go = {
      recognitionType = "extension";
      magicOrExtension = "go";
      interpreter = "/run/current-system/sw/bin/gorun";
      preserveArgvZero = false;
      openBinary = true;
      matchCredentials = true;
      fixBinary = false;
    };
  };
}
