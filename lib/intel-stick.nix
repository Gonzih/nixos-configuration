## Intel compute stick

{ config, lib, pkgs, ... }:

{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

      ./nix/systemd-boot.nix
      ./nix/hosts.nix
      ./nix/networking.nix
      ./nix/networkmanager.nix
      ./nix/packages/config.nix
      ./nix/users.nix
      ./nix/gnzh-user.nix
      ./nix/services.nix
      ./nix/i18n.nix
      ./nix/sudoers.nix
      ./nix/tmpfs.nix
      ./nix/netdata.nix
      ./nix/prometheus-exporter.nix
      ./nix/autofs.nix

      ./nix/overlays/overlays.nix

      ./nix/servers/minecraft.nix

      # ./nix/services/octoprint.nix
      ./nix/services/feeds2imap.nix
  ];

  environment.systemPackages = (import ./nix/packages/base.nix pkgs)
  ++ (import ./nix/packages/feeds2imap.nix pkgs);

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # THIS IS COPIED FRO GENERATED FILE

  boot.initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sdhci_acpi" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5c40ce46-db87-490f-b50e-6b5d416202d5";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/89CC-1835";
      fsType = "vfat";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 4;

  # END OF COPY PASTE

  hardware.cpu.intel.updateMicrocode = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  networking.hostName = "stickmeh";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
