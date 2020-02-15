## Lenovon N55SF config

{ config, lib, pkgs, ... }:

{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ./nix/grub.nix
      ./nix/hosts.nix
      ./nix/udev.nix
      ./nix/networking.nix
      ./nix/networkmanager.nix
      ./nix/packages/config.nix
      ./nix/desktop.nix
      ./nix/users.nix
      ./nix/gnzh-user.nix
      ./nix/services.nix
      ./nix/programs.nix
      ./nix/sound.nix
      ./nix/bumblebee.nix
      ./nix/environment.nix
      ./nix/i18n.nix
      ./nix/sudoers.nix
      ./nix/powermanagement.nix
      ./nix/fonts.nix
      ./nix/docker.nix
      ./nix/binfmt.nix
      ./nix/autofs.nix
      ./nix/gaming.nix
      ./nix/extra-modules.nix
      ./nix/tmpfs.nix
      ./nix/privateinternetaccess.nix
      ./nix/plymouth.nix
      ./nix/netdata.nix

      ./nix/overlays/overlays.nix

      ./nix/services/user/firefox.nix
      ./nix/services/user/redshift.nix
      ./nix/services/user/slack.nix
      ./nix/services/user/spotify.nix
      ./nix/services/user/telegram.nix
      ./nix/services/user/thunderbird.nix

      ./nix/services/rclone-mount.nix

      ./nix/wireguard/clients/for-nas/y700.nix
  ];

  environment.systemPackages = (import ./nix/packages/base.nix pkgs)
  ++ (import ./nix/packages/dev.nix pkgs)
  ++ (import ./nix/packages/k8s.nix pkgs)
  ++ (import ./nix/packages/desktop.nix pkgs)
  ++ (import ./nix/packages/gaming.nix pkgs)
  ++ (import ./nix/packages/virtualization.nix pkgs);

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # THIS IS COPIED FRO GENERATED FILE

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/cookie";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."cookie".device = "/dev/disk/by-uuid/1cb64479-ee48-40c5-aa44-db56dcdfdb89";
  boot.loader.grub.enableCryptodisk = true;
  boot.loader.grub.device = "/dev/sda";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/ca15802f-8698-4b13-9225-f88293badf68";
    fsType = "ext2";
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/df4981b1-680a-4e88-9c7b-725988b4639f"; } ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  powerManagement.powertop.enable = true;

  networking.hostName = "nixos";

  # END OF COPY PASTE

  hardware.cpu.intel.updateMicrocode = true;

  hardware.enableRedistributableFirmware = true; # Might help wifi?

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
