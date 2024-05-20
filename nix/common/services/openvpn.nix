{
  pkgs,
  config,
  ...
}: {
  services.openvpn.servers = {
    cbxnet = {
      config = ''
        config ${config.age.secrets.stack_baumann-cbxgate_cbxnet_de_ovpn.path}
        auth-user-pass  ${config.age.secrets.stack_baumann-cbxgate_cbxnet_de-password.path}
      '';
      autoStart = false;
      updateResolvConf = false;
      #      up = "${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved";
      #      down = "${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved";
    };
  };
  programs.update-systemd-resolved.servers.cbxnet.includeAutomatically = true;
}
