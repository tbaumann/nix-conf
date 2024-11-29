{pkgs, ...}: {
  imports = [
    ./programs
    ./services
    ./backup.nix
    ./wifi.nix
    ./tailscale.nix
  ];
  system.etc.overlay.enable = true;
  boot.initrd.systemd.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader = {
    timeout = 10;
    systemd-boot = {
      enable = true;
      consoleMode = "0";
      configurationLimit = 5;
      memtest86.enable = true;
      netbootxyz.enable = true;
    };
    efi.canTouchEfiVariables = true;
  };
  programs = {
    dconf.enable = true;
    minipro.enable = true;
    adb.enable = true; #adbusers group
    yazi.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
  };
  services = {
    irqbalance.enable = true;
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
  networking.bridges = {
    lan = {
      interfaces = [
        "eno1"
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    btop
    dfu-util
    expect
    fh
    file
    gcc-arm-embedded
    gnumake
    inotify-tools
    jq
    just
    libnotify
    lm_sensors
    localsend
    lsb-release
    lurk
    nix-du
    nix-tree
    openvpn
    pv
    qmk-udev-rules
    # FIXME Broken quickemu
    # FIXME Broken quickgui
    sbctl
    spice
    spice-gtk
    unzip
    update-systemd-resolved
    zip
  ];
  environment.pathsToLink = ["/libexec"];
}
