{
  config,
  ...
}:
{
  services = {
    tailscale = {
      enable = true;
      authKeyFile = config.sops.secrets.tailscale-key.path;
      permitCertUid = "tilli";
      extraUpFlags = [
        "--accept-routes"
        "--ssh"
      ];
    };
  };
}
