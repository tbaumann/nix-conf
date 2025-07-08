{
  config,
  pkgs,
  ...
}: {
  networking.wg-quick.interfaces.secunet-seven = {
    privateKeyFile = config.sops.secrets.secunet-seven-private-key.path;
    address = [
      "198.18.2.11/15"
      "fd00:5ec::20b/48"
    ];
    mtu = 1300;
    peers = [
      {
        allowedIPs = [
          "198.18.0.0/15"
          "fd00:5ec::/48"
        ];
        endpoint = "gateway.seven.secunet.com:51821";
        publicKey = "ZVayNyJeOn848aus5bqYU2ujNxvnYtV3ACoerLtDpg8=";
      }
    ];
  };
  environment.systemPackages = [
    pkgs.devenv
  ];
}
