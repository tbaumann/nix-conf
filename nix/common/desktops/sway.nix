{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];
  programs.sway = {
    enable = true;
    wrapperFeatures.base = true;
    wrapperFeatures.gtk = true;
  };
  services.logind.killUserProcesses = true;
  environment.systemPackages = with pkgs; [
    yambar
    nwg-launchers
    nwg-displays
    nwg-drawer
    nwg-panel
    nwg-dock
    nwg-look
    nwg-menu
    nwg-bar
    swappy
    wlr-randr
  ];
}
