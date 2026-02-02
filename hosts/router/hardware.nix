{
  modulesPath,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  # mkBefore is very important here, otherwise it won't be used over linux-firmware files.
  hardware.firmware = lib.mkBefore [
    (pkgs.stdenvNoCC.mkDerivation {
      name = "BPiR4WiFiFirmware";
      inherit (config.boot.kernelPackages.kernel) src;
      dontPatch = true;
      dontConfigure = true;
      dontBuild = true;
      dontFixup = true;
      installPhase = ''
        mkdir -p $out/lib/firmware/mediatek/mt7996
        mv utils/firmware/mediatek/mt7996/* $out/lib/firmware/mediatek/mt7996/
      '';
    })
  ];

  sbc.bootstrap.rootFilesystem = "btrfs-subvol";
}
