{
  inputs,
  pkgs,
  ...
}: {
  imports = [
  ];
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = ["--disable-up-arrow"];
  };
  home.packages = [pkgs.grc pkgs.fzf];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish | source
      set theme_color_scheme catppuccin
    '';
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
    ];
  };
  xdg.configFile."fish/themes/" = {
    source = "${inputs.catppuccin-fish}/themes";
    recursive = true;
  };
  stylix.targets.fish.enable = false;
  programs.oh-my-posh = {
    enable = true;
    useTheme = "catppuccin_mocha";
    enableFishIntegration = true;
  };
}
