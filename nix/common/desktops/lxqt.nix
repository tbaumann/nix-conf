{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];
  services.xserver.desktopManager.lxqt.enable = true;
}
