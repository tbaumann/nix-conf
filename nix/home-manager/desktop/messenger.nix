{
  inputs,
  pkgs,
  catppuccin-cava,
  ...
}:
# media - control and enjoy audio/video
{
  home.packages = with pkgs; [
    rambox
    slack
    whatsapp-for-linux
    threema-desktop
    dino
  ];
}
