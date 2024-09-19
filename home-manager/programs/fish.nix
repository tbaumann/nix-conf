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
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''
    ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
  '';
  stylix.targets.fish.enable = false;
}
