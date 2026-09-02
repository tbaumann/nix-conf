{
  pkgs,
  inputs,
  ...
}:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    waybar # the status bar
    inputs.waybar_media_display.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.waybar_weather_display.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  # FIXME maybe waybar-mpris
}
