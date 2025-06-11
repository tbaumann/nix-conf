{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;
}
