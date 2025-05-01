{
  pkgs,
  config,
  ...
}: {
  /*
  security.pki.certificateFiles = [
    ./mullvad_ca.crt
  ];

  services.openvpn.servers = {
    mullvad_de_fr = {
      config = ''
        client
        dev tun
        resolv-retry infinite
        nobind
        persist-key
        persist-tun
        verb 3
        remote-cert-tls server
        ping 10
        ping-restart 60
        sndbuf 524288
        rcvbuf 524288
        cipher AES-256-GCM
        tls-cipher TLS-DHE-RSA-WITH-AES-256-GCM-SHA384
        proto udp
        auth-user-pass ${config.sops.secrets.mullvadpw.path}
        ca mullvad_ca.crt
        script-security 2
        #up /etc/openvpn/update-resolv-conf
        #down /etc/openvpn/update-resolv-conf
        fast-io
        remote-random
        remote 146.70.117.66 1302 # de-fra-ovpn-101
        remote 185.213.155.66 1302 # de-fra-ovpn-001
        remote 146.70.117.98 1302 # de-fra-ovpn-102
        remote 185.213.155.67 1302 # de-fra-ovpn-002
        remote 185.213.155.69 1302 # de-fra-ovpn-004
        remote 185.213.155.68 1302 # de-fra-ovpn-003
        remote 185.213.155.70 1302 # de-fra-ovpn-005
      '';
    };
    mullvad_uk_lon = {
      config = ''
        client
        dev tun
        resolv-retry infinite
        nobind
        persist-key
        persist-tun
        verb 3
        remote-cert-tls server
        ping 10
        ping-restart 60
        sndbuf 524288
        rcvbuf 524288
        cipher AES-256-GCM
        tls-cipher TLS-DHE-RSA-WITH-AES-256-GCM-SHA384
        proto udp
        auth-user-pass ${config.sops.secrets.mullvadpw.path}
        ca mullvad_ca.crt
        script-security 2
        #up /etc/openvpn/update-resolv-conf
        #down /etc/openvpn/update-resolv-conf
        fast-io
        remote-random
        remote 185.195.232.86 1197 # gb-lon-ovpn-006
        remote 141.98.252.133 1197 # gb-lon-ovpn-003
        remote 141.98.252.131 1197 # gb-lon-ovpn-001
        remote 141.98.252.132 1197 # gb-lon-ovpn-002
        remote 146.70.119.130 1197 # gb-lon-ovpn-302
        remote 146.70.119.98 1197 # gb-lon-ovpn-301
        remote 185.195.232.85 1197 # gb-lon-ovpn-005

      '';
    };
  };
  programs.update-systemd-resolved.servers.mullvad_de_fr.includeAutomatically = true;
  */
}
