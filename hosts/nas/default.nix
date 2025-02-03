{
  pkgs,
  lib,
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
  systemd.network.enable = true;
  systemd.network.networks."10-lan" = {
    name = "end0";
    DHCP = "ipv4";
    dns = ["8.8.8.8" "1.1.1.1" "1.0.0.1" "8.8.4.4"];
  };
  networking.useDHCP = false;

  services.openssh.enable = true;
  programs.argon.eon = {
    enable = true;
  };
  programs.argon.one = {
    enable = true;
    settings = {
      oled = {
        switchDuration = 10;
        screenList = ["clock" "cpu" "storage" "ram" "temp" "ip"];
      };
      fanspeed = [
        {
          temperature = 55;
          speed = 0;
        }
        {
          temperature = 60;
          speed = 55;
        }
        {
          temperature = 65;
          speed = 100;
        }
      ];
    };
  };

  programs.nix-index-database.comma.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-wrapped-6.0.36"
    "aspnetcore-runtime-6.0.36"
    "dotnet-sdk-wrapped-6.0.428"
    "dotnet-sdk-6.0.428"
  ];
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
        umask = 2;
        download-queue-size = 25;
        rpc-host-whitelist = "${config.networking.hostName}.local";
      };
    };

    bazarr.enable = true;
    lidarr.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    #readarr.enable = true;
    sonarr.enable = true;
  };
  #services.bazarr.group = "media";

  systemd.services.bazarr.serviceConfig.UMask = "0002";

  systemd.services.sonarr.serviceConfig.UMask = "0002";

  systemd.services.radarr.serviceConfig.UMask = "0002";

  systemd.services.jellyfin.serviceConfig.UMask = lib.mkForce "0002";

  services.jellyseerr.enable = true;
  #  systemd.services.jellyseerr.environment.LOG_LEVEL = "warning";

  environment.systemPackages = [
    pkgs.recyclarr
    pkgs.i2c-tools
  ];
  services.grafana = {
    enable = true;
    settings = {
      server.domain = "marrekech.baumann.ma";
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
          url = "http://localhost:${toString config.services.prometheus.port}";
        }
        {
          name = "Loki";
          type = "loki";
          #access = "proxy";
          url = "http://localhost:${toString config.services.loki.configuration.server.http_listen_port}";
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
              #"localhost:${toString config.services.prometheus.exporters.postgres.port}"
              #"localhost:${toString config.services.prometheus.exporters.redis.port}"
              "zuse.local:${toString config.services.prometheus.exporters.node.port}"
              "router.local:${toString config.services.prometheus.exporters.node.port}"
              "zuse-klappi.local:${toString config.services.prometheus.exporters.node.port}"
            ];
          }
        ];
      }
    ];
  };

  /**/
  services.loki = {
    enable = true;
    configuration = {
      server.http_listen_port = 3030;
      auth_enabled = false;

      ingester = {
        lifecycler = {
          address = "127.0.0.1";
          ring = {
            kvstore = {
              store = "inmemory";
            };
            replication_factor = 1;
          };
        };
        chunk_idle_period = "1h";
        max_chunk_age = "1h";
        chunk_target_size = 999999;
        chunk_retain_period = "30s";
      };

      schema_config = {
        configs = [
          {
            from = "2024-10-10";
            store = "boltdb-shipper";
            object_store = "filesystem";
            schema = "v13";
            index = {
              prefix = "index_";
              period = "24h";
            };
          }
        ];
      };

      storage_config = {
        boltdb_shipper = {
          active_index_directory = "/var/lib/loki/boltdb-shipper-active";
          cache_location = "/var/lib/loki/boltdb-shipper-cache";
          cache_ttl = "24h";
        };

        filesystem = {
          directory = "/var/lib/loki/chunks";
        };
      };

      limits_config = {
        reject_old_samples = true;
        reject_old_samples_max_age = "168h";
        allow_structured_metadata = false;
      };

      table_manager = {
        retention_deletes_enabled = false;
        retention_period = "0s";
      };

      compactor = {
        working_directory = "/var/lib/loki";
        compactor_ring = {
          kvstore = {
            store = "inmemory";
          };
        };
      };
    };
    # user, group, dataDir, extraFlags, (configFile)
  };

  /*
  services.immich = {
    port = 2282;
    host = "nas.local";
    enable = true;
    mediaLocation = "${config.nixarr.mediaDir}/immich";
    machine-learning.enable = false;
  };
  services.prometheus.exporters.postgres = {
    enable = true;
    runAsLocalSuperUser = true;
  };
  */
  services.resolved.enable = true;
  services.resolved.dnssec = "false";
  services.ntpd-rs.metrics.enable = true;
  networking.hostName = "nas";

  system.stateVersion = "24.05";
}
