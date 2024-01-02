{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];
  programs.wshowkeys.enable = true;
  services.xserver.windowManager.hypr.enable = true;
  programs = {
    hyprland.enable = true;
    xwayland.enable = true;

    # monitor backlight control
    light.enable = true;

    # thunar file manager(part of xfce) related options
    thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    waybar # the status bar
    swayidle # the idle timeout
    swaylock # locking the screen
    wlogout # logout menu
    wl-clipboard # copying and pasting
    hyprpicker # color picker
    wf-recorder # creen recording
    grim # taking screenshots
    slurp # selecting a region to screenshot
    # TODO replace by `flameshot gui --raw | wl-copy`

    mako # the notification daemon, the same as dunst

    yad # a fork of zenity, for creating dialogs

    # audio
    alsa-utils # provides amixer/alsamixer/...
    networkmanagerapplet # provide GUI app: nm-connection-editor

    xfce.thunar # xfce4's file manager
  ];

  # fix https://github.com/ryan4yin/nix-config/issues/10
  security.pam.services.swaylock = {};
}
