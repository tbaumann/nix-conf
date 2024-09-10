{pkgs, ...}: {
  boot.initrd.systemd.enable = true;
  boot.kernelPackages = pkgs.linuxPackages;
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
  environment.systemPackages = with pkgs; [
    quickemu
    quickgui
    openvpn
    update-systemd-resolved
    inotify-tools
    libnotify
    s5cmd
    spice
    spice-gtk
    localsend
    fh
    pv
    just
    lurk
  ];
}
