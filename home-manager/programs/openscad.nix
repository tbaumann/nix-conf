{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [openscad];
  #  programs.nixvim.plugins.openscad = {
  #  enable = true;
  # };
}
