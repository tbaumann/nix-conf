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
    };
    home-manager.enable = true;
    yazi.enable = true;
    lsd.enable = true;
    nix-index-database.comma.enable = true;
    fastfetch = {
      enable = true;
      settings = 
      {
  "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
  modules = [
    "title"
    "separator"
    "os"
    #"host"
    #"bios"
    "bootmgr"
    #"board"
    #"chassis"
    "kernel"
    #"initsystem"
    #"uptime"
    #"loadavg"
    #"processes"
    "packages"
    "shell"
    "editor"
    "display"
    "brightness"
    "monitor"
    #"lm"
    "de"
    "wm"
    #"wmtheme"
    #"theme"
    #"icons"
    #"font"
    #"cursor"
    #"wallpaper"
    "terminal"
    #"terminalfont"
    #"terminalsize"
    #"terminaltheme"
    {
      type = "cpu";
      showPeCoreCount = true;
      temp = true;
    }
    #"cpucache"
    "cpuusage"
    /*
    {
      type = "gpu";
      driverSpecific = true;
      temp = true;
    }
    */
    "memory"
    "physicalmemory"
    {
      type = "swap";
      separate = true;
    }
    "disk"
    "btrfs"
    "zpool"
    {
      type = "battery";
      temp = true;
    }
    "poweradapter"
    #"player"
    #"media"
    {
      type = "publicip";
      timeout = 1000;
    }
    {
      type = "localip";
      showIpv6 = true;
    }
    #"dns"
    "wifi"
    "datetime"
    #"locale"
    "vulkan"
    "opengl"
    "opencl"
    #"users"
    "bluetooth"
    "bluetoothradio"
    #"sound"
    #"camera"
    #"gamepad"
    #"mouse"
    #"keyboard"
    /*
    {
      type = "weather";
      timeout = 1000;
    }
    */
    "netio"
    "diskio"
    {
      type = "physicaldisk";
      temp = true;
    }
    #"tpm"
    #"version"
  ];
};
    };
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
