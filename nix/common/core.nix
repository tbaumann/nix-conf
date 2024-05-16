{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./programs
    ./services
    ./user-group.nix
    ./fhs-fonts.nix
    ./core-desktop.nix
    ./backup.nix
    ./wifi.nix
    ./tailscale.nix
    ../home-manager/default.nix
    #./hardening.nix
  ];
  nix = {
    daemonCPUSchedPolicy = "idle";
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "1h";
    };
    settings = {
      auto-optimise-store = true;
      trusted-users = ["@wheel"];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      cores = 12;
      max-jobs = 4;
      # access-tokens = "github.com=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";
    };
  };

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader = {
    timeout = 10;
    systemd-boot = {
      enable = true;
      consoleMode = "0";
      configurationLimit = 15;
      memtest86.enable = true;
      netbootxyz.enable = true;
    };
    efi.canTouchEfiVariables = true;
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
    quickemu
    quickgui
    ripgrep
    zip
    unzip
    qmk-udev-rules
    gcc-arm-embedded
    dfu-util
  ];

  services = {
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
    neovim.enable = true;
    vim.defaultEditor = true;
    dconf.enable = true;
    fish.enable = true;
    minipro.enable = true;
    adb.enable = true; #adbusers group
  };

  # FUCK Morocco
  networking.enableIPv6 = false;

  networking.firewall.enable = false;

  networking.bridges = {
    lan = {
      interfaces = [
        "eno1"
      ];
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  users.groups = {
    "plugdev" = {};
    "netdev" = {};
    "pulse" = {};
    "power" = {};
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "23.05"; # Did you read the comment?
}
