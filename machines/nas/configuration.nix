{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = with inputs; [
    #./common/secrets.nix
    nix-topology.nixosModules.default
    nixarr.nixosModules.default
    impermanence.nixosModules.impermanence
    nixos-sbc.nixosModules.default
    nixos-sbc.nixosModules.boards.raspberrypi.rpi4
    argon40-nix.nixosModules.default
    nix-index-database.nixosModules.nix-index
    nixos-hardware.nixosModules.common-pc-ssd
    clan-core.clanModules.state-version
    clan-core.clanModules.root-password
    ./hardware-configuration.nix
    ../../common/profiles/minimal.nix
    #../../common/profiles/perlless.nix
    ../../common/core.nix
    ../../common/services/homepage.nix
    ../../common/user-group.nix
    ../../common/tailscale.nix
    ./storage.nix
  ];

  nixpkgs.hostPlatform.system = "aarch64-linux";
  clan.core.deployment.requireExplicitUpdate = true;
  topology.self = {
    hardware.info = "Raspberry Pi NAS";
    interfaces.wlan0 = {
      network = "home"; # Use the network we define below
    };
  };

  services.avahi.enable = true;
  networking.hostName = "nas";
  security.sudo.wheelNeedsPassword = false;
  security.sudo-rs.enable = true;
  security.sudo-rs.execWheelOnly = true;
  security.sudo-rs.wheelNeedsPassword = false;
  systemd.sysusers.enable = false; #FIXME https://github.com/ryantm/agenix/issues/238 https//github.com/Mic92/sops-nix/issues/475

  services.openssh.enable = true;
  services.ntpd-rs.metrics.enable = true;
  /*
  systemd.network.enable = true;
  systemd.network.networks."10-lan" = {
    name = "end0";
    DHCP = "ipv4";
    dns = ["8.8.8.8" "1.1.1.1" "1.0.0.1" "8.8.4.4"];
  };
  networking.useDHCP = false;
  */

  networking.interfaces.end0.ipv4.addresses = [
    {
      address = "192.168.1.2";
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = {
    address = "192.168.1.1";
    interface = "end0";
  };
  networking.nameservers = ["8.8.8.8" "1.1.1.1" "1.0.0.1" "8.8.4.4"];

  services.resolved.enable = true;
  services.resolved.dnssec = "false";

  programs.nix-index-database.comma.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-wrapped-6.0.36"
    "aspnetcore-runtime-6.0.36"
    "dotnet-sdk-wrapped-6.0.428"
    "dotnet-sdk-6.0.428"
  ];
  /*
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
  */

  environment.systemPackages = [
    pkgs.recyclarr
    pkgs.i2c-tools
  ];
  /*
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

  */
}
