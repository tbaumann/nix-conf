{pkgs, ...}: {
  imports = [
  ];
  programs.sway = {
    enable = true;
    wrapperFeatures.base = true;
    wrapperFeatures.gtk = true;
  };
  services.logind.settings.Login.killUserProcesses = false;
}
