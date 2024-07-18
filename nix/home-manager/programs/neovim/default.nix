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
#    ./nixvim
    #    ./astronvim.nix
  ];
  /*
  nixpkgs.overlays = [
      (final: prev: {
        neovim = inputs.nixvim-config.packages.x86_64-linux.default;
      })
    ];
  */
  home.packages = with pkgs; [
        inputs.nixvim-config.packages.x86_64-linux.default
    
  ];
}
