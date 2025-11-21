{pkgs, ...}: {
  home.packages = with pkgs; [
    goose-cli
    poppler-utils
  ];
  programs.opencode = {
    enable = true;
  };
}
