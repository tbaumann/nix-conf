{
  inputs,
  config,
  pkgs,
  environment,
  ...
}: {
  imports = [
    inputs.agenix.nixosModules.default
    ./programs
    ./user-group.nix
    ./fhs-fonts.nix
    ./core-desktop.nix
    ./backup.nix
    ./wifi.nix
    ./tailscale.nix
    ../home-manager/default.nix
  ];
  nix = {
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
    };
  };

  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 15;
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
    ripgrep
    lm_sensors
    inputs.agenix.packages.x86_64-linux.default
    jq
    parallel
    expect
    nix-output-monitor
    btop
    lsb-release
    autorestic
    nixpkgs-review
    zip
  ];

  services = {
    resolved.enable = true;
    avahi = {
      enable = true;
      publish.enable = true;
      publish.workstation = true;
      publish.addresses = true;
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
    thermald.enable = true;
    udisks2.enable = true;
  };

  programs = {
    command-not-found.enable = false;
    nix-index.enable = true;
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
