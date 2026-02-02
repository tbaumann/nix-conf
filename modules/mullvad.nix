{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  options.mullvad = {
    enable = mkEnableOption "Enable Mullvad VPN configuration";
    privateKeyFile = mkOption {
      type = types.path;
      description = "Path to the private key file";
    };
    locations = mkOption {
      type = types.attrsOf (types.listOf (types.submodule {
        options = {
          endpoint = mkOption {
            type = types.str;
            description = "Server endpoint address with port";
          };
          publicKey = mkOption {
            type = types.str;
            description = "Server's public key";
          };
        };
      }));
      default = {};
      description = "VPN locations mapping directly to server lists";
    };
  };

  config = let
    cfg = config.mullvad;

    # Generate all interfaces as { name, server } pairs
    allInterfaces = lib.concatLists (lib.mapAttrsToList (
        locationName: servers:
          lib.imap1 (index: server: {
            name = "${lib.strings.sanitizeDerivationName locationName}-${lib.strings.fixedWidthNumber 3 (index + 1)}";
            inherit server;
          })
          servers
      )
      cfg.locations);
  in
    lib.mkIf cfg.enable {
      networking.wg-quick.interfaces = lib.listToAttrs (map ({
          name,
          server,
        }: {
          inherit name;
          value = {
            dns = ["10.64.0.1"];
            address = [
              "10.75.3.80/32"
              "fc00:bbbb:bbbb:bb01::c:34f/128"
            ];
            inherit (cfg) privateKeyFile;
            peers = [
              {
                inherit (server) publicKey;
                allowedIPs = ["0.0.0.0/0" "::0/0"];
                inherit (server) endpoint;
              }
            ];
            autostart = false;
            mtu = 1280; # Telekom Hybrid
          };
        })
        allInterfaces);

      systemd.services = let
        serviceNames = map ({name, ...}: "wg-quick-${name}") allInterfaces;
        serviceNamesWithSuffix = map (n: "${n}.service") serviceNames;
      in
        lib.genAttrs serviceNames (serviceName: {
          conflicts = lib.filter (n: n != "${serviceName}.service") serviceNamesWithSuffix;
        });
    };
}
