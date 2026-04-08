{pkgs, ...}: {
  home.packages = with pkgs; [
    kicad
    # FIXME openscad dependency broken    kikit
    #    librepcb
  ];
}
