{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    #     hyprland.homeManagerModules.default

    ./anyrun.nix
    ./wayland-apps.nix
  ];

  #wayland.windowManager.hyprland.enable = true;
  # hyprland configs, based on https://github.com/notwidow/hyprland
  home.file.".config/hypr" = {
    source = ./hypr-conf;
    # copy the scripts directory recursively
    recursive = true;
  };

  # music player - mpd
  home.file.".config/mpd" = {
    source = ./mpd;
    recursive = true;
  };

  home.packages = with pkgs; [
    hicolor-icon-theme
    wttrbar
    swaylock-effects
    hyprpaper
  ];

  # allow fontconfig to discover fonts and configurations installed through home.packages
  fonts.fontconfig.enable = true;
}
