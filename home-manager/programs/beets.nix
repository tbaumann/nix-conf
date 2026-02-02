{ inputs, ... }:
{
  imports = [
  ];
  programs.beets.enable = true;
  programs.beets.settings = {
    directory = "~/Music";
    import = {
      move = "yes";
    };
  };
}
