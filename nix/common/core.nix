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
    package = pkgs.nixFlakes;
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
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      cores = 24;
      max-jobs = 24;
      # access-tokens = "github.com=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";
    };
    buildMachines = [
      {
        hostName = "zuse.local";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        # if the builder supports building for multiple architectures,
        # replace the previous line by, e.g.
        # systems = ["x86_64-linux" "aarch64-linux"];
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
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
  environment.pathsToLink = ["/libexec"];

  time.timeZone = "Africa/Casablanca";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.supportedLocales = ["all"];
  console = {
    keyMap = "us";
  };

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
    autorestic
    btop
    expect
    file
    gnumake
    jq
    lm_sensors
    lsb-release
    nix-output-monitor
    nixpkgs-review
    parallel
    ripgrep
    zip
    unzip
    qmk-udev-rules
    gcc-arm-embedded
    dfu-util
    sbctl
    # FIXME next version wcurl
  ];

  services = {
    ntpd-rs.enable = true;
    irqbalance.enable = true;
    resolved.enable = true;
    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        workstation = true;
        addresses = true;
        userServices = true;
      };
    };
    dbus.enable = true;
    fstrim.enable = true;
    dbus.implementation = "broker";
    fwupd = {
      enable = true;
      extraRemotes = ["lvfs-testing"];
    };
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    printing.enable = true;
    udisks2.enable = true;
  };

  programs = {
    command-not-found.enable = false;
    #    programs.nix-ld.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    fish.enable = true;
    neovim.enable = true;
    vim.defaultEditor = true;
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
