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
  fileSystems = {
    "/media" = {
      device = "/dev/disk/by-label/media";
      fsType = "btrfs";
      #options = ["subvol=media"];
    };
  };
}
