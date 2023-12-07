{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];
  services.xserver.desktopManager.gnome.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];
  services.gnome.core-utilities.enable = true;
  programs.file-roller.enable = true;
  programs.seahorse.enable = false;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    gnome-music
    gnome-terminal
    epiphany # web browser
    geary # email reader
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);
}
