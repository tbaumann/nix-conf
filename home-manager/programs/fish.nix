{
  inputs,
  pkgs,
  ...
}: {
  imports = [
  ];
  home.packages = [pkgs.grc pkgs.fzf];
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = ["--disable-up-arrow"];
  };
  programs.fish = {
    enable = true;
    shellInitLast = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish | source
      set theme_color_scheme catppuccin
    '';
  };
  xdg.configFile."fish/themes/" = {
    source = "${inputs.catppuccin-fish}/themes";
    recursive = true;
  };
  stylix.targets.fish.enable = false;
  programs.oh-my-posh = {
    enable = true;
    #useTheme = "catppuccin_mocha";
    enableFishIntegration = true;
  };
}
