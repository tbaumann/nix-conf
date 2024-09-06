{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
  ];

  nixpkgs.overlays = [
    (final: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // {allowMissing = true;});
    })
  ];

  nixpkgs.config.allowUnsupportedSystem = true;
  /*
  nixpkgs.hostPlatform.system = "aarch64-linux";
  nixpkgs.buildPlatform.system = "x86_64-linux"; #If you build on x86 other wise changes this.

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
