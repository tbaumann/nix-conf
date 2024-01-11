{pkgs, ...}: {
  home.packages = with pkgs; [
    openfortivpn
  ];
}
