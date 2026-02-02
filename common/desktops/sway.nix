{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
  ];
  programs.sway = {
    enable = true;
    wrapperFeatures.base = true;
    wrapperFeatures.gtk = true;
  };
  #services.logind.settings.Login.killUserProcesses = true;
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

  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors = {
    sway = {
      prettyName = "Sway";
      comment = "Sway managed by UWSM";
      binPath = "/run/current-system/sw/bin/sway";
    };
  };
}
