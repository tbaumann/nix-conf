{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/shared.nix
    ../../common/core.nix
    ../../common/core-pc.nix
    inputs.preservation.nixosModules.default
    inputs.espuino-mediahub.nixosModules.default

  ];
  preservation = {
    # the module doesn't do anything unless it is enabled
    enable = true;

    preserveAt."/persist" = {

      # preserve system directories
      directories = [
        "/etc/secureboot"
        "/etc/ssh"
        "/var/lib/bluetooth"
        "/var/lib/fprint"
        "/var/lib/fwupd"
        "/var/lib/kubelet"
        "/var/lib/libvirt"
        "/var/lib/longhorn"
        "/var/lib/sops-nix"
        # k3s server/agent state (SQLite DB, TLS/CA, containerd images)
        "/var/lib/rancher"
        # data-mesher synced files (dm-dns zone)
        "/var/lib/data-mesher"
        # ESPuino MediaHub state (db.json: devices/cards/projects + secret.key).
        # Volatile by default, so a plain reboot silently wipes cards and their
        # assignments (the media library itself lives on @media and is safe).
        {
          directory = "/var/lib/espuino-mediahub";
          user = "mediahub";
          group = "mediahub";
          mode = "0750";
        }
        "/var/lib/power-profiles-daemon"
        "/var/lib/systemd/coredump"
        "/var/lib/systemd/rfkill"
        "/var/lib/systemd/timers"
        "/var/log"
      ];

      # preserve system files
      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
        # k3s config + admin kubeconfig (contains the cluster token/CA)
        {
          file = "/etc/rancher/k3s/config.yaml";
          how = "symlink";
          configureParent = true;
        }
        {
          file = "/etc/rancher/k3s/k3s.yaml";
          how = "symlink";
          configureParent = true;
        }

        # creates a symlink on the volatile root
        # creates an empty directory on the persistent volume, i.e. /persistent/var/lib/systemd
        # does not create an empty file at the symlink's target (would require `createLinkTarget = true`)
        {
          file = "/var/lib/systemd/random-seed";
          how = "symlink";
          inInitrd = true;
          configureParent = true;
        }

        # systemd's host credential key. libvirt 12.8 encrypts
        # /var/lib/libvirt/secrets/secrets-encryption-key with `systemd-creds`
        # using that key; since /var/lib/libvirt IS preserved, the key has to be
        # preserved as well or the blob becomes undecryptable after a reboot
        # (libvirtd then fails with status=243/CREDENTIALS).
        # Bind-mounted, NOT symlinked: systemd-creds opens this file with
        # O_NOFOLLOW, so a symlink makes it fail with ELOOP ("Too many levels of
        # symbolic links") and it can never (re)create the key.
        {
          file = "/var/lib/systemd/credential.secret";
          mode = "0400";
          configureParent = true;
        }
      ];

      # preserve user-specific files, implies ownership
      users = {
        root = {
          # specify user home when it is not `/home/${user}`
          home = "/root";
          directories = [
            {
              directory = ".";
              mode = "0700";
            }
          ];
        };
      };
    };
  };

  system.nixos-init.enable = lib.mkForce false;
  systemd.oomd.enable = true;
  documentation.enable = false;
  documentation.man.enable = false;
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };
  networking.useNetworkd = lib.mkForce true;
  networking.useDHCP = lib.mkDefault true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  services.thermald.enable = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  #system.etc.overlay.enable = lib.mkForce false;
  users.mutableUsers = false;

  services.espuino-mediahub = {
    enable = true;
    mediaDir = "/media/espuino-mediahub";
    openFirewall = true;
  };

  # Single-node Kubernetes server, declaratively provisioned with nixidy
  # (see ../..//nixidy/nuc).
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [
      # Make the admin kubeconfig readable so nixidy/kubectl can use it as a
      # non-root user (e.g. `KUBECONFIG=/etc/rancher/k3s/k3s.yaml`).
      "--write-kubeconfig-mode"
      "0644"
      # Run Traefik as a nixidy-managed application (see nixidy/nuc) instead of
      # k3s's bundled one, so its full config is declarative in this repo.
      "--disable"
      "traefik"
      # k3s's servicelb (klipper-lb) exposes LoadBalancer Services with a
      # hostPort, and containerd's CNI portmap then installs a wildcard DNAT for
      # that port (`nat OUTPUT -m addrtype --dst-type LOCAL`) that also swallows
      # 127.0.0.53 — so any client resolving through /etc/resolv.conf on this
      # node (containerd image pulls, Go binaries) is hijacked into the LB pod.
      # MetalLB (nixidy app `metallb`) hands out real L2 VIPs instead.
      "--disable"
      "servicelb"
    ];
  };

  # Longhorn (node-local block storage, managed via nixidy) requires iSCSI
  # initiator (iscsiadm) on every node for its block volumes to attach.
  services.openiscsi = {
    enable = true;
    # Unique initiator name per node — reverse of a domain we own, so the
    # namespace is ours and every host is distinguishable on a future SAN
    # (Longhorn itself only needs iscsiadm installed; the IQN matters once we
    # attach external iSCSI targets).
    name = "iqn.2026-09.name.baumann.tilman:nuc";
  };

  # Longhorn's manager nsenters into the host mount namespace and runs
  # `iscsiadm` with the CONTAINER's PATH (which has /usr/bin but not
  # /run/current-system/sw/bin). NixOS only installs iscsiadm under
  # /run/current-system/sw/bin, so Longhorn can't find it. Expose it at
  # /usr/bin/iscsiadm via a tmpfiles symlink (survives rebuilds).
  systemd.tmpfiles.rules = [
    "L+ /usr/bin/iscsiadm - - - - ${pkgs.openiscsi}/bin/iscsiadm"
  ];

  # Kubernetes API server + the nixidy-managed Traefik ingress (HTTP/HTTPS).
  networking.firewall.allowedTCPPorts = [
    6443
    80
    443
  ];
}
