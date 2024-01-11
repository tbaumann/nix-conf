{inputs, ...}: {
  services = {
    syncthing = {
      enable = true;
      user = "tilli";
      configDir = "/home/tilli/.config/syncthing"; # Folder for Syncthing's settings and keys
      dataDir = "/home/tilli/.config/syncthing/db"; # Folder for Syncthing's database
      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      settings = {
        gui.enabled = true; # Enable the WebUI
        options.localAnnounceEnabled = true;
        options.urAccepted = -1;
        devices = {
          "zuse" = {id = "GHTDDYR-6RQRJUI-5A2Z5LO-3ST4SUQ-44VQWBW-FBV73TI-WIU3VWC-3T2RKQX";};
          "zuse-klappi" = {id = "GPCIPUK-DLVJIY3-AXF5DFV-C2RKI22-WKI2TIQ-PWGWPLH-MRSKYTW-GRZFAQR";};
          "phone" = {id = "Z3EPAXF-JMPX7BH-SY3HTXR-5TWJNSR-RMHUR3D-WP4Q2OU-DPPUTLQ-CJUYGQE";};
        };
        overrideFolders = true; # overrides any folders added or deleted through the WebUI
        folders = {
          "Documents" = {
            # Name of folder in Syncthing, also the folder ID
            path = "/home/tilli/Documents"; # Which folder to add to Syncthing
            devices = ["zuse" "zuse-klappi"];
          };
          "Downloads" = {
            path = "/home/tilli/Downloads/";
            devices = ["zuse" "zuse-klappi"];
          };
          "Pictures" = {
            path = "/home/tilli/Pictures/";
            devices = ["zuse" "zuse-klappi"];
          };
          "Phone Camera" = {
            path = "/home/tilli/Pictures/Phone";
            devices = ["zuse" "phone"];
          };
          "DT" = {
            path = "/home/tilli/DT";
            devices = ["zuse" "zuse-klappi"];
            ignorePerms = false;
          };
          "git" = {
            path = "/home/tilli/git";
            devices = ["zuse" "zuse-klappi"];
            ignorePerms = false;
          };
          "Music" = {
            path = "/home/tilli/Music";
            devices = ["zuse" "zuse-klappi"];
            autoNormalize = false;
          };
          "Phone Music" = {
            path = "/home/tilli/Music/Phone";
            devices = ["zuse" "phone"];
            autoNormalize = false;
          };
          "Videos" = {
            path = "/home/tilli/Videos";
            devices = ["zuse" "zuse-klappi"];
            autoNormalize = false;
          };
          "Wallpapers" = {
            path = "/home/tilli/wallpapers";
            devices = ["zuse" "zuse-klappi"];
          };
        };
      };
    };
  };
  # Syncthing ports: 8384 for remote access to GUI
  # 22000 TCP and/or UDP for sync traffic
  # 21027/UDP for discovery
  # source: https://docs.syncthing.net/users/firewall.html
  networking.firewall.allowedTCPPorts = [8384 22000];
  networking.firewall.allowedUDPPorts = [22000 21027];
}
