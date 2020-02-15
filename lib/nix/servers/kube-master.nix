{ config, pkgs, lib, ... }:

{
  services.kubernetes = {
    roles = [ "master" "node" ];
    masterAddress = "localhost";
    easyCerts = true;

    pki = {
      etcClusterAdminKubeconfig = "/etc/kubernetes/cluster-admin.kubeconfig";
    };

    addons = {
      dashboard.enable = true;
      dashboard.rbac.enable = true;
      dns.enable = true;
    };
  };
}
