{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages = {
      snapraid-btrfs = pkgs.callPackage ./pkgs/snapraid-btrfs.nix {};
      snapraid-btrfs-runner = pkgs.callPackage ./pkgs/snapraid-btrfs-runner.nix {snapraid-btrfs = self'.packages.snapraid-btrfs;};
    };
  };
}
