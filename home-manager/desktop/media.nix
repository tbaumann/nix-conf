{
  inputs,
  pkgs,
  ...
}:
# media - control and enjoy audio/video
{
  home.packages = with pkgs; [
    # audio control
    pavucontrol
    playerctl
    pulsemixer
    imv # simple image viewer

    sayonara

    # nvtop
    amdgpu_top

    # video/audio tools
    libva-utils
    vdpauinfo
    vulkan-tools
    glxinfo
    ffmpeg-full
    handbrake

    # video
    vlc
    libdvdcss
    totem

    # images
    viu # Terminal image viewer with native support for iTerm and Kitty
    imagemagick
  ];

  programs = {
    mpv = {
      enable = true;
      #defaultProfiles = ["gpu-hq"];
      #scripts = [pkgs.mpvScripts.mpris];
    };
  };

  services = {
    playerctld.enable = true;
  };
}
