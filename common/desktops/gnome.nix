{
  pkgs,
  ...
}:
{
  imports = [
  ];
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = true;
  environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];
  programs.file-roller.enable = true;
  programs.seahorse.enable = false;
  services.gnome.gcr-ssh-agent.enable = false;
}
