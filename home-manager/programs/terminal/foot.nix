{inputs, ...}: {
  #stylix.targets.foot.enable = false;
  programs.foot = {
    enable = true;
    settings = {
      main = {
        #include = "~/.config/foot/themes/themes/catppuccin-mocha.ini";
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
