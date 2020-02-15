## X230 laptop in server mode

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

      ./nix/wireguard/clients/for-nas/x230.nix
  ];

  environment.systemPackages = (import ./nix/packages/base.nix pkgs)
  ++ (import ./nix/packages/dev.nix pkgs)
  ++ (import ./nix/packages/k8s.nix pkgs)
  ++ (import ./nix/packages/desktop.nix pkgs);

  services.fprintd.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # THIS IS COPIED FRO GENERATED FILE
  boot.loader.grub.device = "/dev/sda";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # 24514560..
  boot.kernelParams = [ "resume_offset=24514560" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3be4047b-3717-499c-ac72-177eab31305b";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/697d9e09-3a27-4803-b88b-9da5f48d1b6b";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/90cc108d-9204-4145-ae0a-72c4382d9b3f";
      fsType = "ext2";
    };

  swapDevices = [ { device = "/var/swapfile"; size = 16384; } ];
  boot.resumeDevice = "/dev/mapper/cryptroot";

  nix.maxJobs = lib.mkDefault 4;

  # END OF COPY PASTE

  hardware.cpu.intel.updateMicrocode = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  powerManagement.powertop.enable = true;

  networking.hostName = "x230";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
