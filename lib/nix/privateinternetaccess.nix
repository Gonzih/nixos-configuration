{ config, pkgs, ... }:

let
  secrets = import ./../secrets.nix;
  carsa2048pem = pkgs.writeText "ca.rsa.2048.pem" secrets.openvpn.privateinternetaccess.pem;
  carsa2048crt = pkgs.writeText "ca.rsa.2048.crt" secrets.openvpn.privateinternetaccess.crt;
  piaConfig = pkgs.writeText "privateinternetaccess.ovpn" ''
    client
    dev tun
    proto udp
    remote belgium.privateinternetaccess.com 1198
    resolv-retry infinite
    nobind
    persist-key
    persist-tun
    cipher aes-128-cbc
    auth sha1
    tls-client
    remote-cert-tls server
    comp-lzo
    verb 1
    reneg-sec 0
    crl-verify ${carsa2048pem}
    ca ${carsa2048crt}
    disable-occ

    script-security 2
  '';
in
{
  services.openvpn.servers.privateinternetaccess = {
    config = '' config ${piaConfig} '';
    autoStart = false;
    updateResolvConf = true;
    authUserPass = {
      username = secrets.openvpn.privateinternetaccess.user;
      password = secrets.openvpn.privateinternetaccess.password;
    };
  };
}
