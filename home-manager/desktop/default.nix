{pkgs, ...}: {
  imports = [
    #./vscode.nix
    ./gtk.nix
    ./gtk-lock.nix
    ./hyprland
    ./media.nix
    ./messenger.nix
    ./nwg-panel.nix
    ./sway.nix
    ./waybar.nix
    ./wlogout.nix
    ./xdg.nix
    ./dt.nix
  ];

  home.packages = with pkgs; [
    # misc
    flameshot
    joplin-desktop
    syncthingtray-minimal
    sway-audio-idle-inhibit
  ];
  programs.zathura.enable = true;

  /*
  services.syncthing.tray = true;
  systemd.user.services.syncthingtray.Service.ExecStart = pkgs.lib.mkForce
    "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/sleep 5; ${pkgs.syncthingtray-minimal}/bin/syncthingtray'";
  */
  #  stylix.targets.kde.enable = false;
  programs.wpaperd = {
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
