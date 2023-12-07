{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ulauncher
  ];

  home.file.".config/ulauncher/" = {
    source = ./config;
    recursive = true;
  };
}
