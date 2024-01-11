{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./neovim
    ./fish.nix
    ./starship.nix
    ./terminal
    ./chromium.nix
  ];

  programs = {
    firefox.enable = true;
    home-manager.enable = true;
    lsd.enable = true;
    lsd.enableAliases = true;
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
    "text/html" = ["firefox.desktop"];
    "application/pdf" = ["evince.desktop" "firefox.desktop"];
  };
}
