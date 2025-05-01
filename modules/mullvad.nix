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
      type = types.attrsOf (types.submodule {
        options = {
          servers = mkOption {
            type = types.listOf (types.submodule {
              options = {
                endpoint = mkOption {
                  type = types.str;
                  description = "Server endpoint address";
                };
                publicKey = mkOption {
                  type = types.str;
                  description = "Public key for this server";
                };
              };
            });
            description = "List of servers for this location";
          };
        };
      });
      default = {};
      description = "VPN locations and their servers";
    };
  };

  config = let
    cfg = config.mullvad;

    # Function to create all interfaces
    mkAllInterfaces = lib.concatLists (lib.mapAttrsToList (
        locationName: location:
          lib.imap1 (index: server: {
            name = "${lib.strings.sanitizeDerivationName locationName}-${lib.strings.fixedWidthNumber 3 (index + 1)}";
            value = {
              dns = ["10.64.0.1"];
              address = [
                "10.75.3.80/32"
                "fc00:bbbb:bbbb:bb01::c:34f/128"
              ];
              privateKeyFile = cfg.privateKeyFile;
              peers = [
                {
                  publicKey = server.publicKey;
                  allowedIPs = ["0.0.0.0/0" "::0/0"];
                  endpoint = server.endpoint;
                }
              ];
              autostart = false;
            };
          })
          location.servers
      )
      cfg.locations);
  in
    lib.mkIf cfg.enable {
      networking.wg-quick.interfaces = lib.listToAttrs mkAllInterfaces;
    };
}
