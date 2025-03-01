{...}: {
  services = {
    syncthing = {
      enable = true;
      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      settings = {
        gui.enabled = true; # Enable the WebUI
        tray.enable = true;
        options = {
          localAnnounceEnabled = true;
          urAccepted = -1;
          relaysEnabled = true;
        };
        # FIXME information leak. Ue AGE
        devices = {
          "zuse" = {id = "GHTDDYR-6RQRJUI-5A2Z5LO-3ST4SUQ-44VQWBW-FBV73TI-WIU3VWC-3T2RKQX";};
          "zuse-klappi" = {id = "GPCIPUK-DLVJIY3-AXF5DFV-C2RKI22-WKI2TIQ-PWGWPLH-MRSKYTW-GRZFAQR";};
          "phone" = {id = "Z3EPAXF-JMPX7BH-SY3HTXR-5TWJNSR-RMHUR3D-WP4Q2OU-DPPUTLQ-CJUYGQE";};
        };
        overrideFolders = true; # overrides any folders added or deleted through the WebUI
        folders = {
          "Documents" = {
            path = "~/Documents"; # Which folder to add to Syncthing
            devices = ["zuse" "zuse-klappi"];
          };
          "Downloads" = {
            path = "~/Downloads/";
            devices = ["zuse" "zuse-klappi"];
          };
          "Pictures" = {
            path = "~/Pictures/";
            devices = ["zuse" "zuse-klappi"];
          };
          "Phone Camera" = {
            path = "~/Pictures/Phone";
            devices = ["zuse" "phone"];
          };
          "Music" = {
            path = "~/Music";
            devices = ["zuse" "zuse-klappi"];
            autoNormalize = false;
          };
          "Phone Music" = {
            path = "~/Music/Phone";
            devices = ["zuse" "phone"];
            autoNormalize = false;
          };
          "Videos" = {
            path = "~/Videos";
            devices = ["zuse" "zuse-klappi"];
            autoNormalize = false;
          };
          "Wallpapers" = {
            path = "~/wallpapers";
            devices = ["zuse" "zuse-klappi"];
          };
        };
      };
    };
  };
}
