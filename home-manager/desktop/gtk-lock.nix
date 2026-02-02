{
  pkgs,
  lib,
  ...
}:
let
  toINI = pkgs.lib.generators.toINI { };
in
{
  home.packages = with pkgs; [
    gtklock
  ];
  xdg.configFile."gtklock/config.ini".text = toINI {
    main = {
      gtk-theme = "Adwaita-dark";
      modules = "${pkgs.gtklock-powerbar-module}/lib/gtklock/powerbar-module.so;${pkgs.gtklock-playerctl-module}/lib/gtklock/playerctl-module.so;${pkgs.gtklock-userinfo-module}/lib/gtklock/userinfo-module.so";
    };
  };
}
