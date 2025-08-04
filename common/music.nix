{
  config,
  lib,
  pkgs,
  ...
}: let
  musicDir = "/srv/music";
  playlistsDir = "${musicDir}/playlists";
in {
  environment.systemPackages = [];
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-iris
      mopidy-local
      mopidy-mpd
      mopidy-mpris
      mopidy-youtube
    ];

    configuration = ''
      [http]
      hostname = 127.0.0.1
      port = 6680

      [file]
      enabled = true
      media_dirs =
          ${musicDir}|Music

      [m3u]
      enabled = true
      base_dir = ${musicDir}
      playlists_dir = ${playlistsDir}
      default_encoding = utf-8
      default_extension = .m3u8
    '';
  };
}
