{pkgs, ...}: {
  imports = [
    ./alacritty.nix
    ./kitty.nix
    ./foot.nix
    ./wezterm.nix
  ];
  home.packages = with pkgs; [
    lsix
    libsixel
  ];
}
