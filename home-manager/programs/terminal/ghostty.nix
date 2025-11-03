{inputs, ...}: {
  stylix.targets.ghostty.enable = false;
  programs.ghostty = {
    enable = true;
    installVimSyntax = true;
    enableFishIntegration = true;
    settings = {
      font-family = "TX-02";
      #theme = "catppuccin-mocha";
      font-size = 19;
      font-thicken = true;
      keybind = [
        #"global:cmd+grave_accent=toggle_quick_terminal"
        #"cmd+shift+d=new_split:right"
      ];
      cursor-style = "block";
      link-url = true;
      window-inherit-working-directory = true;
      window-inherit-font-size = true;
      clipboard-trim-trailing-spaces = true;
      mouse-hide-while-typing = true;
      #custom-shader = "${inputs.ghostty-shaders}/in-game-crt.glsl";
    };
  };
}
