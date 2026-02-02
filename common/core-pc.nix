{
  pkgs,
  inputs,
  system,
  ...
}: {
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
      extraRemotes = ["lvfs-testing"];
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
      drivers = with pkgs; [gutenprint hplip foomatic-db-ppds];
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
  ];
  environment.pathsToLink = ["/libexec"];
}
