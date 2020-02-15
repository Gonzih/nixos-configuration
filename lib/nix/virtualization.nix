{ config, pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true;
    qemuPackage = pkgs.qemu_kvm;
    qemuVerbatimConfig = ''
      nvram = [ "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
    '';
  };

  users.groups.libvirtd.members = [ "root" "gnzh" ];
  virtualisation.virtualbox.host.enable = true;
}
