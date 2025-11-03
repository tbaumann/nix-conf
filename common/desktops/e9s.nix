{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];
  services.xserver.desktopManager.enlightenment.enable = false;
}
