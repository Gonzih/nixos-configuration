{ config, pkgs, ... }:

{
  security.sudo.configFile =
    ''
        # Don't edit this file. Set the NixOS option ‘security.sudo.configFile’ instead.
        # Environment variables to keep for root and %wheel.
        Defaults:root,%wheel env_keep+=LOCALE_ARCHIVE
        Defaults:root,%wheel env_keep+=NIX_CONF_DIR
        Defaults:root,%wheel env_keep+=NIX_PATH
        Defaults:root,%wheel env_keep+=TERMINFO_DIRS
        Defaults:root,%wheel env_keep+=HOME
        # Keep SSH_AUTH_SOCK so that pam_ssh_agent_auth.so can do its magic.
        Defaults env_keep+=SSH_AUTH_SOCK
        # "root" is allowed to do anything.
        root        ALL=(ALL) SETENV: ALL
        # Users in the "wheel" group can do anything.
        %wheel      ALL=(ALL) SETENV: ALL
    '';
}
