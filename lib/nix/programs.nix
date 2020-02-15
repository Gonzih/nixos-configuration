{ config, pkgs, ... }:

{
  programs.ssh = {
    startAgent = false;
    forwardX11 = false;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.fish.enable = true;
  programs.adb.enable = true;
}
