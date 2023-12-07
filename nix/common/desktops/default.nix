{pkgs, ...}:{
  imports = [
    ./kde.nix
    ./lxqt.nix
    ./hyprland.nix
    ./budgie.nix
    ./sway.nix
    ./wpaperd.nix
  #  ./gnome.nix  Gnome xdg portal grashes. Don't need it anyway.
  ];

  hardware.opengl.driSupport = true;
  services.xserver = {
    enable = true;
    videoDrivers = [
      "amdgpu"
      "intel"
    ];
    desktopManager = {
      xterm.enable = false;
    };
  };
  programs.regreet = {
    enable = true;
    settings.background = {
      path = pkgs.nixos-artwork.wallpapers.stripes-logo.gnomeFilePath;
      fit = "Cover";
    };
  };
}
