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
  home.file.".config/hypr/themes".source = "${inputs.catppuccin-hyprland}/themes";

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

  systemd.user.sessionVariables = {
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
    "MOZ_WEBRENDER" = "1";

    "XDG_SESSION_TYPE" = "wayland";
    "WLR_NO_HARDWARE_CURSORS" = "1";
    "WLR_EGL_NO_MODIFIRES" = "1";
  };
}
