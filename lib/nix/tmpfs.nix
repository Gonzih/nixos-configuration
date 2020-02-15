{ config, pkgs, ... }:

{
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
}
