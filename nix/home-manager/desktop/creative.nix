{pkgs, ...}: {
  home.packages = with pkgs; [
  ];

  programs = {
    # live streaming
    obs-studio.enable = true;
  };
}
