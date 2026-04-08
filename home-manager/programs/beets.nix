{...}: {
  imports = [
  ];
  programs.beets.enable = false; # FIXME build fails because of broken python3.13-sphinx-prompt
  programs.beets.settings = {
    directory = "~/Music";
    import = {
      move = "yes";
    };
  };
}
