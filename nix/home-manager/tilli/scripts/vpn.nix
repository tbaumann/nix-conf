{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "vpn";
      text = ''
        # shellcheck disable=SC1091
        source "${config.age.secrets.vpn-password.path}"
        OTP=$(${pkgs.cloak}/bin/cloak view PAN-Net)

        sudo ${pkgs.openfortivpn}/bin/openfortivpn v01.fortivpn.pan-net.cloud -v -v --no-dns -u "$USERNAME" -p "$PASSWORD$OTP"  --trusted-cert 907d4a83b4823a3b912d1f79f639d18feb990c9ab8af4a37a9e2c1ecfda76dd9 --set-dns=1 --pppd-no-peerdns
      '';
    })
  ];
}
