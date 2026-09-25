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
        "/var/lib/sops-nix"
        # k3s server/agent state (SQLite DB, TLS/CA, containerd images)
        "/var/lib/rancher"
        # data-mesher synced files (dm-dns zone)
        "/var/lib/data-mesher"
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
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          how = "symlink";
          configureParent = true;
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
  services.openssh.enable = true;
  networking.useNetworkd = lib.mkForce true;
  networking.useDHCP = lib.mkDefault true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  services.thermald.enable = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  system.etc.overlay.enable = lib.mkForce false;

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
    ];
  };

  # Kubernetes API server + the nixidy-managed Traefik ingress (HTTP/HTTPS).
  networking.firewall.allowedTCPPorts = [
    6443
    80
    443
  ];
}
