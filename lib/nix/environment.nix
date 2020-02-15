{ config, pkgs, ... }:

{
  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';
  environment.variables = {
  };
}
