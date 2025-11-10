{pkgs, ...}: {
  home.packages = with pkgs; [
    goose-cli
    opencode
  ];
}
