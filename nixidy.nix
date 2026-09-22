{ inputs, ... }: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];
  perSystem =
    {
      pkgs,
      self',
      ...
    }:
    {
      packages = {
      };
    };
}
