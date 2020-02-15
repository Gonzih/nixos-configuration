{ config, pkgs, lib, ... }:

let
  secrets = import ./../../../secrets.nix;
  dir = "/var/www/notes";
  script = ''
    set -eu

    [ -d "${dir}" ] || git clone -b gh-pages https://${secrets.gh.nas_token}@github.com/Gonzih/notes.git ${dir}
    cd ${dir}
    git pull
  '';
  notesScript = pkgs.writeText "notes.sh" script;
in
{
   services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * *      root    bash ${notesScript} 2>&1 >> /dev/null"
    ];
  };

}
