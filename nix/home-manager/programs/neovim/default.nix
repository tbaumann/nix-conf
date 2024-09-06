{
  inputs,
  pkgs,
  astronvim,
  lib,
  ...
}: {
  imports = [
    ./nixvim/default.nix
    #    "${inputs.nixvim-kickstart}/nixvim.nix"
    #    "${inputs.nixvim-kickstart}/plugins/kickstart/plugins/debug.nix"
    #    "${inputs.nixvim-kickstart}/plugins/kickstart/plugins/indent-blankline.nix"
    #    "${inputs.nixvim-kickstart}/plugins/kickstart/plugins/lint.nix"
    #    "${inputs.nixvim-kickstart}/plugins/kickstart/plugins/autopairs.nix"
    #    "${inputs.nixvim-kickstart}/plugins/kickstart/plugins/neo-tree.nix"
  ];
}
