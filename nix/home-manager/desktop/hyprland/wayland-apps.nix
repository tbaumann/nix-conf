{pkgs, ...}: {
  # TODO vscode & chrome both have wayland support, but they don't work with fcitx5, need to fix it.
  programs = {
    # source code: https://github.com/nix-community/home-manager/blob/master/modules/programs/chromium.nix

    firefox = {
      enable = true;
      enableGnomeExtensions = false;
      package = pkgs.firefox-wayland; # firefox with wayland support
    };
  };
}
