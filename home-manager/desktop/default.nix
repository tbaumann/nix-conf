{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    #./vscode.nix
    ./gtk.nix
    ./gtk-lock.nix
    ./media.nix
    ./messenger.nix
    ./niri
    ./sway.nix
    ./waybar.nix
    ./wlogout.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    # misc
    flameshot
    syncthingtray-minimal
    sway-audio-idle-inhibit
    #inputs.quickshell.packages.${pkgs.system}.default
  ];
  programs.zathura.enable = true;
  programs.joplin-desktop = {
    enable = true;
    sync = {
      target = "joplin-cloud";
      interval = "30m";
    };
  };

  stylix.targets.kde.enable = false;
  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = "~/wallpapers/";
        duration = "1h";
        sorting = "random";
      };
    };
  };
  systemd.user.sessionVariables = {
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
    "MOZ_WEBRENDER" = "1";
    "QT_QPA_PLATFORM" = "wayland;xcb";
    "SDL_VIDEODRIVER" = "wayland,x11";

    "XDG_SESSION_TYPE" = "wayland";
    "WLR_NO_HARDWARE_CURSORS" = "1";
    "WLR_EGL_NO_MODIFIRES" = "1";
  };
}
