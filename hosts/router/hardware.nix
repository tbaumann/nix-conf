{
  modulesPath,
  nixos-hardware,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  sbc.bootstrap.rootFilesystem = "btrfs-subvol";
}
