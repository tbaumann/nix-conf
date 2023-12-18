{
  inputs,
  pkgs,
  nix-colors,
  ...
}: {
  imports = [
    ./desktop
    ./packages.nix
    ./programs
    ./services.nix
#    nix-colors.homeManagerModules.default
  ];

 colorScheme = nix-colors.colorSchemes.catppuccin-macchiato;

  #  xdg.userDirs = {
  #    enable = true;
  #    createDirectories = true;
  #  };
  home = {
    /*
       breaks shit. Not sure why I should have it. Bloody cargo cult
    sessionVariables = {
      # TODO: Not sure what the right way of doing this is...
      # The list of packages is a subset of `GI_TYPELIB_PATH` in `nix-shell -p gobject-introspection gtk4`.
      GI_TYPELIB_PATH = "$GI_TYPELIB_PATH:${pkgs.gobject-introspection.out}/lib/girepository-1.0:${pkgs.gtk4.out}/lib/girepository-1.0:${pkgs.graphene.out}/lib/girepository-1.0:${pkgs.gdk-pixbuf.out}/lib/girepository-1.0:${pkgs.harfbuzz.out}/lib/girepository-1.0:${pkgs.pango.out}/lib/girepository-1.0";
      LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.glib.out}/lib";
    };
    */
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";
  };
}
