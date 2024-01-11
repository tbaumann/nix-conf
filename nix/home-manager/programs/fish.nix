{inputs, ...}: {
  imports = [
  ];
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = ["--disable-up-arrow"];
  };
  programs.fish.enable = true;
  stylix.targets.fish.enable = false;
}
