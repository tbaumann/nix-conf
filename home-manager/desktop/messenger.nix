{
  inputs,
  nixpkgs-unstable,
  pkgs,
  ...
}:
# media - control and enjoy audio/video
{
  home.packages = [
    pkgs.rambox
  ];
}
