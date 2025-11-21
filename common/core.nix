{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./user-group.nix
    ./nixbuild.nix
    ../modules/email.nix
    #./syncthing.nix
  ];

  email = {
    enable = true;
    fromAddress = "admin@tilman.baumann.name";
    toAddress = "tilman.baumann@tilman.baumann.name";
    smtpServer = "smtp.migadu.com";
    smtpUsername = "tilman.baumann@tilman.baumann.name";
    smtpPasswordPath = config.sops.secrets.smtpPassword.path;
  };
  sops.secrets.nix-access-tokens-github.mode = "0444";
  clan.core.settings.state-version.enable = true;
  clan.core.settings.machine-id.enable = true;
  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    extraOptions = ''
      experimental-features = nix-command flakes
      builders-use-substitutes = true
      !include ${config.sops.secrets.nix-access-tokens-github.path}
    '';
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "1h";
    };
    settings = {
      download-buffer-size = 500000000; # 500 MB
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

  system.switch = {
    enable = true;
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

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.supportedLocales = ["all"];
  console = {
    keyMap = "us";
  };
  system.etc.overlay.enable = true;
  system.etc.overlay.mutable = true;
  boot.initrd.systemd.enable = true;
  system.nixos-init.enable = true;

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
    inputs.clan-core.packages.x86_64-linux.clan-cli
    bat
    nix-output-monitor
    nixpkgs-review
    parallel
    ripgrep
    rsync
    bcachefs-tools
    btop
    nix-index
    nixfmt-rfc-style
  ];

  services = {
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
    smartd = {
      enable = true;
      notifications = {
        systembus-notify.enable = true;
        mail = {
          enable = true;
          sender = config.email.fromAddress;
          recipient = config.email.toAddress;
        };
      };
    };
  };

  programs = {
    command-not-found.enable = false;
    fish.enable = true;
    vim.enable = true;
    vim.defaultEditor = true;
  };

  networking.firewall.enable = false;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  users.groups = {
    "plugdev" = {};
    "netdev" = {};
    "pulse" = {};
    "power" = {};
  };
  environment.variables = {
    PAGER = "${pkgs.bat}/bin/bat";
  };
}
