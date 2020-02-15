let secrets = import ./../secrets.nix; in

{ config, pkgs, lib, ... }:

{
  services.autofs = {
    enable = true;
    debug = false;

    autoMaster = let
      host = "192.168.2.100";
      shares = [
        "backups"
        "tmp"
        "music"
        "video"
        "photos"
        "work"
      ];
      credsContent = secrets.credentials.samba;
      creds =  pkgs.writeText "sambacredentials" credsContent;
      gen = pkgs.lib.foldl (acc: share: acc + "${share} -fstype=cifs,credentials=${creds},uid=gnzh,gid=gnzh,file_mode=0777,dir_mode=0777,cache=strict,rsize=130048,rsize=131007,vers=2.1 ://${host}/${share}\n") "";
      myConf = gen shares;
      mapConf = pkgs.writeText "auto" ''
        /net	-hosts

        ${myConf}
      '';
    in ''
      /auto file:${mapConf}
    '';
  };
}
