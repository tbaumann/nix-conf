{pkgs, ...}: {
  imports = [
    ./creative.nix
    ./gtk.nix
    ./media.nix
    ./xdg.nix
    ./messenger.nix
    ./hyprland
    ./sway.nix
    ./vscode.nix
    ./ulauncher
    ./hikari.nix
    ./nwg-panel.nix
  ];

  home.packages = with pkgs; [
    # misc
    flameshot
    joplin-desktop
    syncthingtray-minimal
  ];

  /*
  services.syncthing.tray = true;
  systemd.user.services.syncthingtray.Service.ExecStart = pkgs.lib.mkForce
    "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/sleep 5; ${pkgs.syncthingtray-minimal}/bin/syncthingtray'";
  */
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
}
