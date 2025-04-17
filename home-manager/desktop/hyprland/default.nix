{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    #     hyprland.homeManagerModules.default

    #    ./anyrun.nix
    ./wayland-apps.nix
  ];

  home.packages = with pkgs; [
    hicolor-icon-theme
    wttrbar
    swaylock-effects
  ];

  # allow fontconfig to discover fonts and configurations installed through home.packages
  fonts.fontconfig.enable = true;
}
