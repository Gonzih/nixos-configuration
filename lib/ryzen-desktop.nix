## Ryzen Desktop PC

{ config, lib, pkgs, ... }:

{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ./nix/systemd-boot.nix
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
      ./nix/fonts.nix
      ./nix/docker.nix
      # ./nix/binfmt.nix
      ./nix/autofs.nix
      ./nix/gaming.nix
      ./nix/extra-modules.nix
      # ./nix/virtualization.nix
      ./nix/tmpfs.nix
      ./nix/privateinternetaccess.nix
      ./nix/plymouth.nix
      ./nix/netdata.nix
      ./nix/prometheus-exporter.nix

      ./nix/overlays/overlays.nix

      ./nix/services/user/firefox.nix
      ./nix/services/user/redshift.nix
      ./nix/services/user/slack.nix
      ./nix/services/user/spotify.nix
      ./nix/services/user/telegram.nix
      ./nix/services/user/thunderbird.nix

      ./nix/services/odroid.nix

      ./nix/services/rclone-mount.nix
  ];

  environment.systemPackages = (import ./nix/packages/base.nix pkgs)
  ++ (import ./nix/packages/dev.nix pkgs)
  ++ (import ./nix/packages/dev-long-compilation.nix pkgs)
  ++ (import ./nix/packages/k8s.nix pkgs)
  ++ (import ./nix/packages/desktop.nix pkgs)
  ++ (import ./nix/packages/gaming.nix pkgs)
  ++ (import ./nix/packages/virtualization.nix pkgs);

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # THIS IS COPIED FRO GENERATED FILE

  # PCI PASSTHROUGH SPECIFIC CONFIGURATION BEGIN

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" "coretemp" "it87" ];
  boot.blacklistedKernelModules = [ "k10temp" ];
  # To disable PCI for passthrough
  # boot.extraModprobeConfig = ''
  #   options vfio-pci ids=10de:1c03,10de:10f1
  #   options kvm allow_unsafe_assigned_interrupts=1
  # '';

  # Calculate offset on swap file using
  # filefrag -v /var/swapfile | awk '{if($1=="0:"){print $4}}'
  boot.kernelParams = [ "resume_offset=450560"  "amd_iommu=on" "iommu=pt" "acpi_enforce_resources=lax" ];
  # This is needed for the case when video drivers take over gpus before vfio can access them
  # boot.postBootCommands = ''
  #   DEVS="0000:09:00.0 0000:09:00.1"

  #   for DEV in $DEVS; do
  #     echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
  #   done
  #   modprobe -i vfio-pci
  # '';


  # PCI PASSTHROUGH SPECIFIC CONFIGURATION END

  # This is not working it seems
  boot.extraModulePackages = [ pkgs.linuxPackages_latest.it87 ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/e6afba67-7e77-412f-98b4-520dbd0bb5b4";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."cookie".device = "/dev/disk/by-uuid/a9837450-a04d-4a96-9b51-8e0c08186d73";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B3AD-EA2A";
      fsType = "vfat";
    };

  swapDevices = [ { device = "/var/swapfile"; size = 32768; } ];
  # This points to partition swap file resides on after it gets decrypted
  # THIS IS VERY IMPORTANT TO GET RIGHT
  boot.resumeDevice = "/dev/mapper/cookie";

  nix.maxJobs = lib.mkDefault 16;

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  networking.hostName = "ryzenshine";

  # END OF COPY PASTE

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true; # Might help wifi?

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
