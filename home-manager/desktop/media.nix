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

    # video/audio tools
    libva-utils
    vdpauinfo
    vulkan-tools
    mesa-demos
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
      bindings = {
        "CTRL+1" = "no-osd change-list glsl-shaders set \"${pkgs.anime4k}Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}Anime4K_Restore_CNN_VL.glsl:${pkgs.anime4k}Anime4K_Upscale_CNN_x2_VL.glsl:${pkgs.anime4k}Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode A {HQ}\"";
        "CTRL+2" = "no-osd change-list glsl-shaders set \"${pkgs.anime4k}Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}Anime4K_Restore_CNN_Soft_VL.glsl:${pkgs.anime4k}Anime4K_Upscale_CNN_x2_VL.glsl:${pkgs.anime4k}Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode B {HQ}\"";
        "CTRL+3" = "no-osd change-list glsl-shaders set \"${pkgs.anime4k}Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:${pkgs.anime4k}Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode C {HQ}\"";
        "CTRL+4" = "no-osd change-list glsl-shaders set \"${pkgs.anime4k}Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}Anime4K_Restore_CNN_VL.glsl:${pkgs.anime4k}Anime4K_Upscale_CNN_x2_VL.glsl:${pkgs.anime4k}Anime4K_Restore_CNN_M.glsl:${pkgs.anime4k}Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode A+A {HQ}\"";
        "CTRL+5" = "no-osd change-list glsl-shaders set \"${pkgs.anime4k}Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}Anime4K_Restore_CNN_Soft_VL.glsl:${pkgs.anime4k}Anime4K_Upscale_CNN_x2_VL.glsl:${pkgs.anime4k}Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}Anime4K_Restore_CNN_Soft_M.glsl:${pkgs.anime4k}Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode B+B {HQ}\"";
        "CTRL+6" = "no-osd change-list glsl-shaders set \"${pkgs.anime4k}Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:${pkgs.anime4k}Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}Anime4K_Restore_CNN_M.glsl:${pkgs.anime4k}Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode C+A {HQ}\"";

        "CTRL+0" = "no-osd change-list glsl-shaders clr \"\"; show-text \"GLSL shaders cleared\"";
      };
    };
  };

  services = {
    playerctld.enable = true;
  };
}
