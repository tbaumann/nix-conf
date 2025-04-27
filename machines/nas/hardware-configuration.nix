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
  #boot.supportedFilesystems = [ "bcachefs" ];
  #sbc.bootstrap.enable = false;
  fileSystems = {
    /*
    "/media" = {
      device = "/dev/disk/by-label/media";
      fsType = "btrfs";
      #options = ["subvol=media"];
    };
    "/" = {
      device = "/dev/disk/by-id/ata-KINGSTON_SA400S37480G_50026B7783C781FA-part1";
      fsType = "btrfs";
      options = ["compress=zstd" "subvol=/@"];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/18db6211-ac36-42c1-a22f-5e15e1486e0d";
      fsType = "btrfs";
      options = ["compress=zstd" "subvol=/@boot"];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/18db6211-ac36-42c1-a22f-5e15e1486e0d";
      fsType = "btrfs";
      options = ["compress=zstd" "subvol=/@nix"];
    };
    */
  };
  /*
  swapDevices = [
    {
      device = "/dev/disk/by-partlabel/swap";
      #    randomEncryption.enable = true;  maybe not for suspend
    }
  ];
  */
}
