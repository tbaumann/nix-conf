{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./user-group.nix
    ./nixbuild.nix
    ../modules/email.nix
    #./syncthing.nix
    # perl is bleeding in via git (inputs.nixpkgs + "/nixos/modules/profiles/perlless.nix")
    ./profiles/perlless.nix
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
    channel.enable = false;
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
        "https://numtide.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "selfhostblocks.cachix.org-1:H5h6Uj188DObUJDbEbSAwc377uvcjSFOfpxyCFP7cVs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };
    buildMachines = [
      {
        hostName = "zuse.local";
        speedFactor = 3;
        system = "x86_64-linux";
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
        protocol = "ssh-ng";
        # if the builder supports building for multiple architectures,
        # replace the previous line by, e.g.
        # systems = ["x86_64-linux" "aarch64-linux"];
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          "kvm"
        ];
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
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          "kvm"
        ];
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
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "kvm"
        ];
        mandatoryFeatures = [];
      }
    ];
  };

  nixpkgs.config.allowUnfree = true;

  zramSwap.enable = true;
  boot.tmp.useTmpfs = true;

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
    nix-output-monitor
    parallel
    ripgrep
    rsync
    bcachefs-tools
    btop
    nix-index
    nixfmt
  ];

  services = {
    ntpd-rs = {
      enable = true;
      settings = {
        observability.log-level = "warn";
      };
    };
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
  programs.bat = {
    enable = true;
    settings = {
      paging = "never";
      theme = "Catppuccin Mocha";
      style = "header-filename,snip";
    };
  };
  environment.variables = {
    PAGER = "${pkgs.bat}/bin/bat";
  };
}
