{
  inputs,
  nixpkgs-unstable,
  pkgs,
  ...
}:
# media - control and enjoy audio/video
{
  home.packages = [
    #inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.rambox
    pkgs.rambox
    pkgs.fractal
  ];
}
