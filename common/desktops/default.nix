{pkgs, ...}: {
  imports = [
    ./kde.nix
    ./lxqt.nix
    ./gtk-lock.nix
    ./niri.nix
    #./hyprland.nix
    ./budgie.nix
    ./sway.nix
    ./wpaperd.nix
    ./waybar.nix
    #  ./gnome.nix  Gnome xdg portal grashes. Don't need it anyway.
  ];

  services.displayManager.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = [
      "amdgpu"
      "intel"
    ];
    desktopManager = {
      xterm.enable = false;
    };
  };
  stylix.image = pkgs.nixos-artwork.wallpapers.stripes-logo.gnomeFilePath;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
  stylix.targets.nixos-icons.enable = true;
  stylix.targets.plymouth.enable = true;
  stylix.targets.console.enable = true;
  stylix.autoEnable = true;
  
  stylix.targets.regreet.enable = false;
  programs.regreet = {
    enable = true;
    settings.background = {
      path = pkgs.nixos-artwork.wallpapers.stripes-logo.gnomeFilePath;
      fit = "Cover";
    };
  };
  programs.wshowkeys.enable = true;
  programs = {
    xwayland.enable = true;

    # monitor backlight control
    light.enable = true;

    # thunar file manager(part of xfce) related options
    thunar.enable = true;
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
    wf-recorder # creen recording
    grim # taking screenshots
    slurp # selecting a region to screenshot
    # TODO replace by `flameshot gui --raw | wl-copy`

    mako # the notification daemon, the same as dunst

    yad # a fork of zenity, for creating dialogs

    # audio
    networkmanagerapplet # provide GUI app: nm-connection-editor
  ];
}
