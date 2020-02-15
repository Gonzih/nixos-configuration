{ config, pkgs, lib, ... }:

let
  share = { name, comment }: {
    comment = comment;
    path = "/storage/samba/" + name;
    "guest ok" = "no";
    public = "no";
    browsable = "yes";
    writable = "yes";
    printable = "no";
    "create mask" = "0740";
    "directory mask" = "2775";
    "force user" = "samba";
    "force group" = "samba";
  };
  enableTimeMachine = {
    "fruit:aapl" = "yes";
    "fruit:time machine" = "yes";
    "vfs objects" = "catia fruit streams_xattr";
  };
in
{
  services.samba = {
    package = pkgs.sambaMaster;

    enable = true;
    enableNmbd = false;
    enableWinbindd = false;
    nsswins = false;
    securityType = "user";
    syncPasswordsByPam = false;

    extraConfig = ''
      workgroup = WORKGROUP
      server string = Samba Server
      load printers = no
      interfaces = 192.168.5.0/24 192.168.2.0/24
      dns proxy = no
    '';

    shares = {
      backups = share { name = "backups"; comment = "Backups"; };
      photos = share { name = "photos"; comment = "Photos"; };
      tmp = share { name = "tmp"; comment = "Temp"; };
      work = share { name = "work"; comment = "Work"; };
      video = share { name = "video"; comment = "Video"; };
      music = share { name = "music"; comment = "Music"; };
      documents = share { name = "documents"; comment = "Documents"; };
      timemachine = share { name = "timemachine"; comment = "timemachine"; } // enableTimeMachine;
    };
  };
}
