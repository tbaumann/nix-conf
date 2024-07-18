{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
  ];

/* 
FIXME https://github.com/NixOS/nixpkgs/issues/325952
  environment.systemPackages = with pkgs; [
    kicad
    kikit
    librepcb
  ];
*/
}
