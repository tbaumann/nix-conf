{pkgs, ...}: {
  imports = [
    ./beets.nix
    ./chromium.nix
    ./fish.nix
    ./librewolf.nix
    ./neovim
    ./nushell.nix
    ./obsidian.nix
    ./openscad.nix
    ./sip.nix
    ./ssh.nix
    ./starship.nix
    ./terminal
  ];

  programs = {
    firefox.enable = true;
    home-manager.enable = true;
    lsd.enable = true;
    lsd.enableAliases = true;
    nix-index-database.comma.enable = true;
    fd.enable = true;
    fd.ignores = [
      ".git/"
    ];
  };

  home.packages = with pkgs; [
    devour
  ];

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
    "text/html" = ["firefox.desktop"];
    "application/pdf" = ["zathura.desktop" "evince.desktop" "firefox.desktop"];
  };
  xdg.mimeApps.associations.removed = {
    "application/pdf" = ["chromium-browser.desktop"];
    "image/png" = ["chromium-browser.desktop"];
  };
}
