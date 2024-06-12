{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    kicad
    kikit
    librepcb
  ];
}
