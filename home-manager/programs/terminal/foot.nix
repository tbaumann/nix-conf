{ inputs, ... }:
{
  #stylix.targets.foot.enable = false;
  programs.foot = {
    enable = true;
    settings = {
      main = {
        #include = "~/.config/foot/themes/themes/catppuccin-mocha.ini";
      };
      colors = {
        #alpha = 0.9;
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
  xdg.configFile."foot/themes" = {
    source = "${inputs.catppuccin-foot}/";
    recursive = true;
  };
}
