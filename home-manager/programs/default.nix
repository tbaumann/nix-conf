{pkgs, ...}: {
  imports = [
    ./beets.nix
    ./chromium.nix
    ./ente.nix
    ./fish.nix
    ./helix.nix
    ./kicad.nix
    ./librewolf.nix
    ./librewolf.nix
    ./llm.nix
    ./nushell.nix
    ./nvf.nix
    ./openscad.nix
    ./sip.nix
    ./ssh.nix
    ./terminal
    ./zoxide.nix
  ];

  stylix.targets.firefox.enable = false;
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
    };
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
