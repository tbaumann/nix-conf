{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
  ];

  console.enable = false;
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.hostPlatform.system = "aarch64-linux";
  nixpkgs.buildPlatform.system = "x86_64-linux"; #If you build on x86 other wise changes this.

  /*
  fileSystems."/" = {
    device = "/dev/nvme0n1p4";
    fsType = "btrfs";
    options = ["subvol=SYSTEM/rootfs"];
  };

  swapDevices = [
    {
      device = "/dev/disk/by-label/swap";
      #    randomEncryption.enable = true;  maybe not for suspend
    }
  ];
  */
}
