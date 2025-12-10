{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [inputs.niri-flake.overlays.niri];
  imports = [
    inputs.niri-flake.homeModules.niri
    inputs.dms.homeModules.dankMaterialShell.default
    inputs.dms.homeModules.dankMaterialShell.niri
    ./settings.nix
    ./binds.nix
    ./rules.nix
  ];

  programs.dankMaterialShell = {
    enable = true;
    enableDynamicTheming = false;
    niri = {
      enableSpawn = true;
      enableKeybinds = true;
    };
  };

  home.packages = with pkgs; [
    seatd
    xwayland-satellite
    jaq
  ];
}
