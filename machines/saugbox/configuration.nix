{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    ../../modules/shared.nix

    ../../common/core.nix
    ../../common/core-pc.nix
    inputs.cinephage.nixosModules.default
    inputs.vpn-confinement.nixosModules.default
  ];
  topology.self = {
    hardware.info = "ThinkCenter";
    interfaces.eno1 = {
      network = "home"; # Use the network we define below
    };
  };
  networking.useNetworkd = lib.mkForce true;
  networking.useDHCP = lib.mkDefault true;

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  services.auto-cpufreq.enable = false;

  security.tpm2.enable = lib.mkForce false;
  nixpkgs.hostPlatform = "x86_64-linux";
  boot.loader.systemd-boot.configurationLimit = lib.mkForce 2;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GB
    }
  ];

  vpnNamespaces.mvd = {
    enable = true;
    wireguardConfigFile = "/var/run/secrets/mullvad-de-fra-wg-301.conf";
    accessibleFrom = [
      "192.168.0.0/16"
    ];
    portMappings = [
      {
        from = 9091;
        to = 8080;
      }
    ];
    openVPNPorts = [
      {
        port = 60729;
        protocol = "both";
      }
    ];
  };

  # Add systemd service to VPN network namespace
  systemd.services.qbittorrent.vpnConfinement = {
    enable = true;
    vpnNamespace = "mvd";
  };
  services = {
    cinephage = {
      enable = true;
      ffmpeg = {
        enable = true;
        package = pkgs.ffmpeg-headless;
      };
      media = ["/media/"];
    };
    # sabnzbd.enable = true;
    nzbget = {
      enable = true;
      settings = {
        DestDir = "/media/Downloads";
        /*
        "Server1.Name" = "Prepad-Usenet";
        "Server1.Host" = "news.ssl.nl.prepaid-usenet.de";
        "Server1.Username" = "WonkoTheSane@prepaid-usenet.de";
        */
      };
    };
    qbittorrent = {
      enable = true;
      #webuiPort = 9091;
    };
  };
}
