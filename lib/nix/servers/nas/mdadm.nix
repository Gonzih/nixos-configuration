{ config, pkgs, lib, ... }:

{
  # Enable RAID auto activation
  boot.initrd.mdadmConf = "ARRAY /dev/md0 metadata=1.2 name=localhost.localdomain:0 UUID=95699e57:a1f5b929:1c0fefbe:09b64ad3";
}
