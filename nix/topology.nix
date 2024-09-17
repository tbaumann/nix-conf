{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.topology) mkInternet mkRouter mkConnection mkConnectionRev mkSwitch;
in {
  #inherit (self) nixosConfigurations;

  # Add a node for the internet
  nodes.internet = mkInternet {
    connections = mkConnection "f6600p" "wan1";
  };

  nodes.f6600p = mkRouter "f6600p" {
    info = "ZTE F6600P";
    interfaceGroups = [
      (
        map
        (n: "lan${toString n}")
        (pkgs.lib.range 0 3)
      )
      ["wan1"]
    ];
  };

  nodes.tplink-lr = mkSwitch "TP-Link-lr" {
    info = "TP-Link Living Room";
    interfaceGroups = [
      (
        map
        (n: "lan${toString n}")
        (pkgs.lib.range 0 3)
      )
      ["wlan"]
    ];
    interfaces.lan1.network = "home";
    interfaces.wlan.network = "home";
    connections.wlan = [(mkConnection "tplink-office" "wlan") (mkConnection "zuse-klappi" "eno1")];
    connections.lan1 = [(mkConnection "f6600p" "lan1")];
  };
  nodes.tplink-office = mkSwitch "TP-Link-lr" {
    info = "TP-Link Living Room";
    interfaceGroups = [
      (
        map
        (n: "lan${toString n}")
        (pkgs.lib.range 0 3)
      )
      ["wlan"]
    ];
    interfaces.lan1.network = "home";
    interfaces.wlan.network = "home";
    connections.lan1 = [
      (mkConnection "zuse" "eno1")
      (mkConnection "nas" "eno1")
    ];
  };

  networks.home = {
    name = "Home";
    cidrv4 = "192.168.1.0/24";
  };
}
