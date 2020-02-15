## Home NAS

{ config, lib, pkgs, ... }:

{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

      ./nix/grub.nix
      ./nix/hosts.nix
      ./nix/networkmanager.nix
      ./nix/packages/config.nix
      ./nix/users.nix
      ./nix/gnzh-user.nix
      ./nix/services.nix
      ./nix/i18n.nix
      ./nix/sudoers.nix
      ./nix/docker.nix
      ./nix/tmpfs.nix
      ./nix/netdata.nix
      ./nix/prometheus-exporter.nix

      ./nix/overlays/overlays.nix

      ./nix/servers/nas/mdadm.nix
      ./nix/servers/nas/networking.nix
      ./nix/servers/nas/prometheus.nix
      ./nix/servers/nas/grafana.nix
      ./nix/servers/nas/samba.nix
      ./nix/servers/nas/users.nix
      ./nix/servers/nas/clamav.nix
      ./nix/lib/docker-containers.nix
      ./nix/servers/nas/containers.nix
      ./nix/servers/nas/nginx.nix
      ./nix/servers/nas/cron.nix

      ./nix/wireguard/servers/nas.nix
  ];

  environment.systemPackages = (import ./nix/packages/base.nix pkgs)
  ++ (import ./nix/packages/k8s.nix pkgs)
  ++ (import ./nix/packages/samba.nix pkgs);

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # THIS IS COPIED FRO GENERATED FILE

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.loader.grub.device = "/dev/sdd";

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/0ac5ae03-aeeb-41f7-a901-abeeb419b2f2";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."nas" = {
    device = "/dev/disk/by-uuid/9e2f1586-999e-4772-835c-04f01e05ae43";
    keyFileSize = 4096;
    keyFile = "/dev/sdd";
  };

  boot.initrd.luks.devices."storage" = {
    device = "/dev/disk/by-uuid/90b6bc10-6124-4488-b7e7-78aca9b049db";
    keyFileSize = 4096;
    keyFile = "/dev/sdd";
  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0a50474b-c1f0-4671-9ab2-2d328ddae551";
      fsType = "ext4";
    };

  fileSystems."/storage" =
    { device = "/dev/disk/by-uuid/c4ff44b8-3a0a-4e40-ab54-41e4c24f02ac";
      fsType = "xfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/1cc81a3e-a911-4b34-81bd-9596b00de8d4"; }
    ];

  nix.maxJobs = lib.mkDefault 4;

  # END OF COPY PASTE

  hardware.cpu.intel.updateMicrocode = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  networking.hostName = "nas";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
