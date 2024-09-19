{pkgs, ...}: {
  security.pam.services.gtklock = {};
  environment.systemPackages = with pkgs; [
    gtklock
    gtklock-powerbar-module
    gtklock-playerctl-module
    gtklock-userinfo-module
  ];
}
