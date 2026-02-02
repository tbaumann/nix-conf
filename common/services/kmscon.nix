{ pkgs, ... }:
{
  console = {
    earlySetup = true;
    packages = with pkgs; [
      terminus_font
      powerline-fonts
    ];
    font = "ter-powerline-v32n";
  };

  services.kmscon = {
    enable = true;
    hwRender = true;
  };
}
