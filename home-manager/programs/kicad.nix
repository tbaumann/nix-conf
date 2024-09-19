{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
  ];

  home.packages = with pkgs; [
    kicad
    kikit
    librepcb
  ];
}
