{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];
  services.xserver.desktopManager.enlightenment.enable = true;
}
