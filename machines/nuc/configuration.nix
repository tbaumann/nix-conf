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
        "/var/lib/bluetooth"
        "/var/lib/fprint"
        "/var/lib/fwupd"
        "/var/lib/libvirt"
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
          file = "/etc/ssh/ssh_host_rsa_key";
          how = "symlink";
          configureParent = true;
        }
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
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

  # New machine!
}
