{
  imports = [
    ./chromium.nix
    ./fish.nix
    ./neovim
    ./nushell.nix
    ./obsidian.nix
    ./openscad.nix
    ./sip.nix
    ./starship.nix
    ./terminal
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
