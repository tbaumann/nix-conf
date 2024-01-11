{
  inputs,
  pkgs,
  astronvim,
  ...
}:
###############################################################################
#
#  AstroNvim's configuration and all its dependencies(lsp, formatter, etc.)
#
#e#############################################################################
{
  imports = [
    ./nixvim
    #    ./astronvim.nix
  ];
}
