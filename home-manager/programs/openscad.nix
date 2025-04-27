{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [openscad];
}
