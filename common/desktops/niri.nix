{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    #    inputs.niri-flake.nixosModules.niri
  ];
  nixpkgs.overlays = [inputs.niri-flake.overlays.niri];
  programs.niri.enable = true;
  #niri-flake.cache.enable = true;
  services.iio-niri.enable = true;
}
