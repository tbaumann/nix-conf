{
  imports = [
    ./neovim
    ./fish.nix
    ./starship.nix
    ./terminal
    ./chromium.nix
    ./obsidian.nix
    ./openscad.nix
    ./nushell.nix
  ];

  programs = {
    firefox.enable = true;
    home-manager.enable = true;
    lsd.enable = true;
    lsd.enableAliases = true;
    nix-index-database.comma.enable = true;
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
    "text/html" = ["firefox.desktop"];
    "application/pdf" = ["zathura.desktop" "evince.desktop" "firefox.desktop"];
  };
}
