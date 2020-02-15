{ config, pkgs, ... }:

let
  vname = "vpnname";
  vpnConf = pkgs.writeText "${vname}.ovpn" ''
    client

    tls-client
    auth SHA256
    cipher AES-256-CBC
    remote-cert-tls server
    tls-version-min 1.2

    proto udp
    remote host port
    dev tun

    resolv-retry 5
    nobind
    keepalive 5 30
    comp-lzo
    persist-key
    persist-tun
    verb 3

    route-method exe
    route-delay 2

    key-direction 1
    <ca>
    -----BEGIN CERTIFICATE-----
    -----END CERTIFICATE-----

    </ca>

    <tls-auth>
    #
    # 2048 bit OpenVPN static key
    #
    -----BEGIN OpenVPN Static key V1-----
    -----END OpenVPN Static key V1-----
    </tls-auth>

    <cert>
    -----BEGIN CERTIFICATE-----
    -----END CERTIFICATE-----
    </cert>

    <key>
    -----BEGIN PRIVATE KEY-----
    -----END PRIVATE KEY-----
    </key>
  '';
in
{
  services.openvpn.servers.keybasedname = {
    config = '' config ${vpnConf} '';
    autoStart = false;
    updateResolvConf = true;
  };
}
