{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../common/core.nix
    ../../common/services/homepage.nix
    #../../common/user-group.nix
    ../../common/tailscale.nix
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];
  topology.self = {
    hardware.info = "Raspberry Pi NAS";
    interfaces.wlan0 = {
      network = "home"; # Use the network we define below
    };
  };

  systemd.sysusers.enable = false; #FIXME https://github.com/ryantm/agenix/issues/238

  services.openssh.enable = true;

  nixarr = {
    enable = true;
    mediaDir = "/media";
    stateDir = "/media/.state/nixarr";
    mediaUsers = ["tilli" "chaimae"];

    jellyfin.enable = true;
    transmission = {
      enable = true;
      openFirewall = true;
      extraSettings = {
        umask = 18;
        download-queue-size = 15;
        rpc-host-whitelist = "${config.networking.hostName}.local";
      };
    };

    bazarr.enable = true;
    #lidarr.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    #readarr.enable = true;
    sonarr.enable = true;
  };
  services.jellyseerr.enable = true;
  systemd.services.jellyseerr.environment.LOG_LEVEL = "warning";
  environment.systemPackages = [
    pkgs.recyclarr
  ];
  services.grafana = {
    enable = true;
    domain = "marrekech.baumann.ma";
    settings = {
      server.http_addr = "0.0.0.0";
      analytics.reporting_enabled = false;
    };
    # FIXME security.admin_password
    provision.enable = true;
    provision.datasources = {
      settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          url = "http://nas.local:${toString config.services.prometheus.port}";
        }
      ];
    };
  };
  services.prometheus = {
    enable = true;
    exporters = {
      node.enable = true;
    };
    scrapeConfigs = [
      {
        job_name = "ntp-rs";
        static_configs = [
          {
            targets = ["localhost:9975"];
          }
        ];
      }
      {
        job_name = "node";
        static_configs = [
          {
            targets = [
              "localhost:${toString config.services.prometheus.exporters.node.port}"
              "zuse.local:${toString config.services.prometheus.exporters.node.port}"
              "zuse-klappi.local:${toString config.services.prometheus.exporters.node.port}"
            ];
          }
        ];
      }
    ];
  };

  /*
  services.immich = {
    enable = true;
    mediaLocation = "${config.nixarr.mediaDir}/immich";
  };
  */
  services.resolved.enable = true;
  services.resolved.dnssec = "false";
  services.ntpd-rs.metrics.enable = true;
  networking.hostName = "nas";
}
