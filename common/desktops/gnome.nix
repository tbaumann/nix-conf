{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];
  services.xserver.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [gnomeExtensions.appindicator];
  services.gnome.core-utilities.enable = true;
  programs.file-roller.enable = true;
  programs.seahorse.enable = false;
}
