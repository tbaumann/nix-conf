{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hikari
  ];

}
