{inputs, ...}: {
  imports = [
  ];
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = ["--disable-up-arrow"];
  };
  programs.fish.enable = true;


  home.file.catppuccin-fish-theme = {
    source = "${inputs.catppuccin-fish}/themes/";
    recursive = true;
    target = ".config/fish/themes/";
  };
  home.file.".config/fish/conf.d/choose_theme.fish".text = "fish_config theme choose  \"Catppuccin Mocha\"";
}
