{pkgs, ...}: {
  imports = [
    ./kde.nix
    ./lxqt.nix
    ./hyprland.nix
    ./budgie.nix
    ./sway.nix
    ./wpaperd.nix
    ./waybar.nix
    #  ./gnome.nix  Gnome xdg portal grashes. Don't need it anyway.
  ];

  services.displayManager.enable = true;
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
  stylix.image = pkgs.nixos-artwork.wallpapers.stripes-logo.gnomeFilePath;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
  stylix.targets.nixos-icons.enable = true;
  stylix.targets.plymouth.enable = true;
  stylix.targets.console.enable = true;
  stylix.autoEnable = true;
  programs.regreet = {
    enable = true;
    settings.background = {
      path = pkgs.nixos-artwork.wallpapers.stripes-logo.gnomeFilePath;
      fit = "Cover";
    };
  };
}
