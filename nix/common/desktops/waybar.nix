{
  config,
  pkgs,
  inputs,
  waybar_weather_display,
  waybar_media_display,
  ...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    waybar # the status bar
    inputs.waybar_media_display.packages.x86_64-linux.default
    inputs.waybar_weather_display.packages.x86_64-linux.default
  ];
  # FIXME maybe waybar-mpris
}
