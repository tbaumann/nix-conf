{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kicad
    kikit
    librepcb
  ];
}
