{
  lib,
  ...
}:
{
  services = {
    syncthing = {
      enable = true;
      user = "tilli";
      configDir = lib.mkForce "/home/tilli/.config/syncthing"; # Folder for Syncthing's settings and keys
      dataDir = lib.mkForce "/home/tilli/.config/syncthing/db"; # Folder for Syncthing's database
      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      settings = {
        gui.enabled = true; # Enable the WebUI
        options.localAnnounceEnabled = true;
        overrideFolders = true; # overrides any folders added or deleted through the WebUI
      };
    };
  };
  # Syncthing ports: 8384 for remote access to GUI
  # 22000 TCP and/or UDP for sync traffic
  # 21027/UDP for discovery
  # source: https://docs.syncthing.net/users/firewall.html
  networking.firewall.allowedTCPPorts = [
    8384
    22000
  ];
  networking.firewall.allowedUDPPorts = [
    22000
    21027
  ];
}
