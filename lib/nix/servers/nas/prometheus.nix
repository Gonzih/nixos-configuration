{ config, pkgs, lib, ... }:


{
  services.prometheus2 = {
    enable = true;
    stateDir = "prometheus";

    scrapeConfigs = [
      { job_name = "prometheus";
        static_configs = [
          { targets = [ "127.0.0.1:9090" ]; }
        ];
      }
      { job_name = "netdata-scrape";
        metrics_path = "/api/v1/allmetrics";
        params = {
          format = [ "prometheus" ];
          server = [ "nas-prometheus" ];
        };
        honor_labels = true;
        static_configs = [
          { targets = [
              "127.0.0.1:19999"
              "192.168.2.62:19999"
              "192.168.2.48:19999"
            ];
          }
        ];
      }
      { job_name = "pihole";
        static_configs = [
          { targets = [ "127.0.0.1:9617" ]; }
        ];
      }
      { job_name = "nix-nas";
        static_configs = [
          { targets = [
            "127.0.0.1:9100"
            "192.168.2.62:9100"
            "192.168.2.48:9100"
            ];
          }
        ];
      }
    ];
  };
}
