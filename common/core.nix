{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./user-group.nix
  ];
  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
      builders-use-substitutes = true
      !include ${config.age.secrets.nix-access-tokens-github.path}
    '';
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "1h";
    };
    settings = {
      builders-use-substitutes = true;
      auto-optimise-store = true;
      trusted-users = ["@wheel"];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        "https://selfhostblocks.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "selfhostblocks.cachix.org-1:H5h6Uj188DObUJDbEbSAwc377uvcjSFOfpxyCFP7cVs="
      ];
      cores = 24;
      max-jobs = 24;
      # access-tokens = "github.com=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";
    };
    buildMachines = [
      {
        hostName = "zuse.local";
        system = "x86_64-linux";
        systems = ["x86_64-linux" "aarch64-linux"];
        protocol = "ssh-ng";
        # if the builder supports building for multiple architectures,
        # replace the previous line by, e.g.
        # systems = ["x86_64-linux" "aarch64-linux"];
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        mandatoryFeatures = [];
      }
      {
        hostName = "nas.local";
        system = "aarch64-linux";
        protocol = "ssh-ng";
        # if the builder supports building for multiple architectures,
        # replace the previous line by, e.g.
        # systems = ["x86_64-linux" "aarch64-linux"];
        speedFactor = 3;
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        mandatoryFeatures = [];
      }
      {
        hostName = "router.local";
        system = "aarch64-linux";
        protocol = "ssh-ng";
        # if the builder supports building for multiple architectures,
        # replace the previous line by, e.g.
        # systems = ["x86_64-linux" "aarch64-linux"];
        speedFactor = 2;
        supportedFeatures = ["nixos-test" "benchmark" "kvm"];
        mandatoryFeatures = [];
      }
    ];
  };

  # https://kokada.dev/blog/an-unordered-list-of-hidden-gems-inside-nixos/
  system.switch = {
    enable = false;
    enableNg = true;
  };

  nixpkgs.config.allowUnfree = true;

  boot.tmp.useTmpfs = true;
  systemd.services.nix-daemon = {
    environment.TMPDIR = "/var/tmp";
  };

  security.sudo.wheelNeedsPassword = false;
  security.sudo-rs.enable = true;
  security.sudo-rs.execWheelOnly = true;
  security.sudo-rs.wheelNeedsPassword = false;

  time.timeZone = "Africa/Casablanca";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.supportedLocales = ["all"];
  console = {
    keyMap = "us";
  };
  system.etc.overlay.enable = true;
  system.etc.overlay.mutable = true;
  boot.initrd.systemd.enable = true;

  # add user's shell into /etc/shells
  environment.shells = with pkgs; [
    bash
    fish
  ];
  # set user's default shell system-wide
  users.defaultUserShell = pkgs.fish;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    inputs.ragenix.packages.x86_64-linux.default
    nix-output-monitor
    nixpkgs-review
    parallel
    ripgrep
    rsync
    bcachefs-tools
    btop
    nix-index
    # FIXME next version wcurl
  ];

  services = {
    prometheus.exporters.node = {
      enable = true;
      enabledCollectors = ["systemd" "softirqs" "tcpstat" "wifi" "ethtool" "interrupts" "zoneinfo" "network_route"];
      extraFlags = ["--collector.filesystem.fs-types-exclude=tmpfs,overlay,erofs"];
    };
    promtail = {
      enable = true;
      configuration = {
        server = {
          http_listen_port = 3031;
          grpc_listen_port = 0;
        };
        positions = {
          filename = "/tmp/positions.yaml";
        };
        clients = [
          {
            url = "http://nas.local:3030/loki/api/v1/push";
          }
        ];
        scrape_configs = [
          {
            job_name = "journal";
            journal = {
              max_age = "12h";
              labels = {
                job = "systemd-journal";
              };
            };
            relabel_configs = [
              {
                source_labels = ["__journal__systemd_unit"];
                target_label = "unit";
              }
              {
                source_labels = ["__journal__hostname"];
                target_label = "hostname";
              }
              {
                source_labels = ["__journal_syslog_identifier"];
                target_label = "syslog_identifier";
              }
              {
                # A priority value between 0 ("emerg") and 7 ("debug") formatted as a decimal string.
                # This field is compatible with syslog's priority concept.
                source_labels = ["__journal_priority"];
                target_label = "priority";
              }
              {
                # How the entry was received by the journal service. Valid transports are:
                #  audit, driver, syslog, journal, stdout, kernel
                source_labels = ["__journal__transport"];
                target_label = "transport";
              }
            ];
          }
        ];
      };
      # extraFlags
    };
    ntpd-rs.enable = true;
    resolved.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        workstation = true;
        addresses = true;
        userServices = true;
      };
    };
    fstrim.enable = true;
    dbus.implementation = "broker";
    dbus.enable = true;
  };

  programs = {
    command-not-found.enable = false;
    fish.enable = true;
    neovim.enable = true;
    neovim.defaultEditor = true;
    vim.enable = true;
  };

  # FUCK Morocco
  networking.enableIPv6 = false;

  networking.firewall.enable = false;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  users.groups = {
    "plugdev" = {};
    "netdev" = {};
    "pulse" = {};
    "power" = {};
  };
}
