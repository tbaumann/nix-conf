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
    package = pkgs.sway.override {
      sway-unwrapped = pkgs.swayfx;
      extraSessionCommands = config.programs.sway.extraSessionCommands;
      extraOptions = config.programs.sway.extraOptions;
      withBaseWrapper = config.programs.sway.wrapperFeatures.base;
      withGtkWrapper = config.programs.sway.wrapperFeatures.gtk;
    };
  };
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
