{pkgs, ...}: {
  imports = [
    #./starship.nix
    ./beets.nix
    ./chromium.nix
    ./ente.nix
    ./fish.nix
    ./kicad.nix
    ./helix.nix
    ./librewolf.nix
    ./librewolf.nix
    ./nushell.nix
    ./nvf.nix
    ./openscad.nix
    ./sip.nix
    ./ssh.nix
    ./syncthing.nix
    ./terminal
  ];

  stylix.targets.firefox.enable = false;
  programs = {
    firefox.enable = true;
    home-manager.enable = true;
    yazi.enable = true;
    lsd.enable = true;
    nix-index-database.comma.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    fd.ignores = [
      ".git/"
    ];
  };

  home.packages = with pkgs; [
    croc
    wush
    duf
    termshark
    procs
    ts
    unp
    asciinema
    asciinema-agg
  ];

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
    "text/html" = ["firefox.desktop"];
    "application/pdf" = [
      "zathura.desktop"
      "evince.desktop"
      "firefox.desktop"
    ];
  };
  xdg.mimeApps.associations.removed = {
    "application/pdf" = ["chromium-browser.desktop"];
    "image/png" = ["chromium-browser.desktop"];
  };
}
