{
  pkgs,
  inputs,
  system,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.hyprpanel.overlay
  ];
  home.packages = with pkgs; [ inputs.hyprpanel.packages."${pkgs.system}".default ];
}
