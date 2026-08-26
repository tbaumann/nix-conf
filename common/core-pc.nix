{ pkgs, ... }: {
  imports = [
    ./programs
    ./services
    ./backup.nix
    ./mullvad.nix
    ./wifi.nix
    ./tailscale.nix
  ];
  system.etc.overlay.enable = true;
  boot.initrd.systemd.enable = true;
  #boot.kernelPackages = pkgs.linuxPackages_6_17;
  boot.loader = {
    timeout = 10;
    grub.enable = false;
    systemd-boot = {
      enable = true;
      consoleMode = "0";
      configurationLimit = 5;
      memtest86.enable = true;
      netbootxyz.enable = true;
    };
    # conflicts with facter efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
  };
  systemd.oomd.enable = true;
  programs = {
    dconf.enable = true;
    yazi.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
  };
  services = {
    irqbalance.enable = true;
    fwupd = {
      enable = true;
      extraRemotes = [ "lvfs-testing" ];
    };
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        hplip
        foomatic-db-ppds
      ];
    };
    udisks2.enable = true;
  };
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    abrmd.enable = true;
    tctiEnvironment.enable = true;
  };
  services.logind.settings.Login = {
    HandlePowerKey = "poweroff";
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
    lm_sensors
    localsend
    lsb-release
    lurk
    nix-du
    nix-tree
    openvpn
    pv
    qmk-udev-rules
    quickemu
    quickgui
    sbctl
    spice
    spice-gtk
    unzip
    update-systemd-resolved
    zip
    (writeShellScriptBin "push-to-nix-ci-cache" ''
      set -eu
      set -f # disable globbing
      export IFS=' '

      # Upload with a narinfo cache we discard, so that the narinfo
      # `nix copy` remembers here cannot shadow the signed one the
      # cache serves.
      XDG_CACHE_HOME="$(mktemp -d)"
      export XDG_CACHE_HOME
      trap 'rm -rf "$XDG_CACHE_HOME"' EXIT

      nix copy --to 'https://cache.nix-ci.com?compression=xz&parallel-compression=true' $OUT_PATHS
    '')
  ];
  environment.pathsToLink = [ "/libexec" ];
}
