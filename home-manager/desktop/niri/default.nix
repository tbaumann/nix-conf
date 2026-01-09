{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [inputs.niri-flake.overlays.niri];
  imports = [
    inputs.niri-flake.homeModules.niri
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    ./settings.nix
    ./binds.nix
    ./rules.nix
  ];

  programs.dank-material-shell = {
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
