{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./kde.nix
    ./lxqt.nix
    ./gtk-lock.nix
    ./niri.nix
    ./budgie.nix
    ./sway.nix
    ./waybar.nix
    ./e9s.nix
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
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  stylix = {
    targets = {
      nixos-icons = {
        enable = true;
      };
      plymouth = {
        enable = true;
        logoAnimated = true;
      };
      console = {
        enable = true;
      };
      qt = {
        enable = false;
      };
    };
  };
  #  stylix.targets.kde.enable = false;
  stylix.autoEnable = true;

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
    thunar.plugins = with pkgs; [
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

    yad # a fork of zenity, for creating dialogs

    # audio
    networkmanagerapplet # provide GUI app: nm-connection-editor
  ];
}
