{
  pkgs,
  config,
  ...
}: {
  services.openvpn.servers = {
  };
  #  programs.update-systemd-resolved.servers.cbxnet.includeAutomatically = true;
}
