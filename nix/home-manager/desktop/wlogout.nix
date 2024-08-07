{pkgs, ...}: {
  programs.wlogout.enable = true;
  programs.wlogout.layout = [
    {
      "label" = "lock";
      "action" = "${pkgs.swaylock-effects}/bin/swaylock --daemonize --grace 0";
      "text" = "Lock";
      "keybind" = "l";
    }
    {
      "label" = "hibernate";
      "action" = "systemctl hibernate";
      "text" = "Hibernate";
      "keybind" = "h";
    }
    {
      "label" = "logout";
      "action" = "swaymsg exit";
      "text" = "Logout";
      "keybind" = "e";
    }
    {
      "label" = "shutdown";
      "action" = "systemctl poweroff";
      "text" = "Shutdown";
      "keybind" = "s";
    }
    {
      "label" = "suspend";
      "action" = "systemctl suspend";
      "text" = "Suspend";
      "keybind" = "u";
    }
    {
      "label" = "reboot";
      "action" = "systemctl reboot";
      "text" = "Reboot";
      "keybind" = "r";
    }
  ];
}
