{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./ghostty.nix
    ./kitty.nix
    ./foot.nix
    ./wezterm.nix
  ];
  home.packages = with pkgs; [
    lsix
    libsixel
  ];
  programs.zellij.enable = true;
  programs.zellij.enableFishIntegration = false;
  programs.fd.enable = true;
}
