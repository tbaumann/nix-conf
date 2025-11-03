{pkgs, ...}: {
  home.packages = with pkgs; [
    twinkle
    # FIXME broken build linphone
  ];
}
