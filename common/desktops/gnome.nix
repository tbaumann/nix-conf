{ pkgs, ... }: {
  imports = [
  ];
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = true;
  services.gnome.core-os-services.enable = true;
  environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];
  programs.seahorse.enable = false;
  services.gnome.gcr-ssh-agent.enable = false;
  programs.evolution.enable = false;
}
