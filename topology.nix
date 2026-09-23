{
  inputs,
  ...
}:
{
  imports = [ inputs.nix-topology.flakeModule ];

  perSystem =
    { system, ... }:
    {
      topology.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [ inputs.nix-topology.overlays.default ];
      };
      topology.modules = [
        (
          { config, ... }:
          let
            inherit (config.lib.topology)
              mkInternet
              mkRouter
              mkSwitch
              mkConnection
              ;
          in
          {
            # The shared LAN segment all machines sit on.
            networks.home = {
              name = "Home";
              cidrv4 = "192.168.2.0/24";
            };

            # Telekom Speedport: the gateway to the internet.
            nodes.speedport = mkRouter "Telekom Speedport" {
              info = "Telekom Speedport";
              interfaceGroups = [
                [ "lan1" ]
                [ "wan1" ]
              ];
              connections.wan1 = mkConnection "internet" "*";
              connections.lan1 = mkConnection "wlan-bridge" "uplink";
            };

            # WLAN bridge: the wireless bridge/access-point that links the
            # router to every machine. Acts as a dumb switch on the LAN.
            nodes.wlan-bridge = mkSwitch "WLAN Bridge" {
              info = "Wireless bridge / access point";
              interfaceGroups = [
                [
                  "uplink"
                  "zuse"
                  "zuse-klappi"
                  "saugbox"
                  "nas"
                  "nuc"
                ]
              ];
              connections.uplink = mkConnection "speedport" "lan1";
              connections.zuse = mkConnection "zuse" "eno1";
              connections.zuse-klappi = mkConnection "zuse-klappi" "wlan0";
              connections.saugbox = mkConnection "saugbox" "eno1";
              connections.nas = mkConnection "nas" "end0";
              connections.nuc = mkConnection "nuc" "eno1";
            };

            # The internet, reachable through the Speedport.
            nodes.internet = mkInternet {
              connections = mkConnection "speedport" "wan1";
            };
          }
        )
      ];
    };
}
