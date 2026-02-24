{
  pkgs,
  lib,
  ...
}:
# media - control and enjoy audio/video
{
  nixpkgs.config.allowUnfree = lib.mkForce true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "rambox"
    ];
  home.packages = with pkgs; [
    signal-desktop-bin
    fractal
    ferdium
  ];
}
