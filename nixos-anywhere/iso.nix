# This module defines a small NixOS installation CD.  It does not
# contain any graphical stuff.
{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];
  config = {
    networking.wireless = {
      enable = true;
      networks = {
        BAUMANN = { psk = "ykuBq6rj";};
        Tilman = { psk = "Fanculo19";};
      };
    };
    networking.enableIPv6 = false;
    # enable nixos-anywhere-installer.local
    networking.hostName = "nixos-anywhere-installer";
    services.avahi.enable = true;
    services.avahi.publish.enable = true;
    services.avahi.publish.workstation = true;
    # Enable SSH in the boot process.
    systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
    systemd.services.wpa_supplicant.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
    systemd.services.avahi-daemon.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD06odwjYayF8YNuuzVydz5/aA8oo7HuPi/S1L7spbxRDU9h+QnSgOlrQkky1g8s+x39MHMLUF/6SZOOQHinBCecTmpGUF/QpPjWSQHafIURjat3L4dScsupVc+IwmbDgLkUxMux/PLkfzxk2YdqpojzcILI5kvGNR2PPEs/vYp2+nqry9TjDfz4OCv4b+FtjqzlZalrSbt9wkTTWK/Sd7AlAQegkOLKB+IrBORIEKknYC+UnyCr5HH+aAD0qgKp3cxh2dIUUEDu3wSyCzv/nus1NqHIaNSfCxwNNrUd53XJOg2wwIV8NQZ0R7md4wYwdWR/I5DM9iH8ckj8kkj/isyKC49vfuOucsQhApQErM4TYVbO5Ckym72TzUUJYzaRVgVAOfOnCsrjW9ihh/RSYWTFnjq6X8QUp6NX3BdUYyoKtxvbKzFdggNPEr4hLpSfOJzHqFJCdH2lyC8Apd1Y56Km+eBz/46kbvaUCvwfgSbQr/lOQzWq63w3S7lnB597/c= tilli@zuse"
    ];
  };
}
