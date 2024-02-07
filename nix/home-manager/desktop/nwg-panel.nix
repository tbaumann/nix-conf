{pkgs, ...}: {
  xdg.configFile."nwg-panel/config".source = ./nwg-panel/config;
  home.packages = with pkgs; [
    nwg-panel
    gopsuinfo
  ];
}
