# XDG stands for "Cross-Desktop Group", with X used to mean "cross".
# It's a bunch of specifications from freedesktop.org intended to standardize desktops and
# other GUI applications on various systems (primarily Unix-like) to be interoperable:
#   https://www.freedesktop.org/wiki/Specifications/
{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    xdg-utils # provides cli tools such as `xdg-mime` `xdg-open`
    xdg-user-dirs
  ];

  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    # manage $XDG_CONFIG_HOME/mimeapps.list
    # xdg search all desktop entries from $XDG_DATA_DIRS, check it by command:
    #  echo $XDG_DATA_DIRS
    # the system-level desktop entries can be list by command:
    #   ls -l /run/current-system/sw/share/applications/
    # the user-level desktop entries can be list by command(user ryan):
    #  ls /etc/profiles/per-user/ryan/share/applications/
    mimeApps.enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
    desktopEntries = {
      /*
      baby = {
        name = "Baby Monitor";
        # MPV is natve waiyland but has audio issues with this camera
        # exec = "${pkgs.mpv}/bin/mpv -title=baby r rtsp://admin:OJIFUR@192.168.100.70:554/ch1/main";
        exec = "${pkgs.vlc}/bin/vlc --qt-minimal-view  --meta-title baby rtsp://admin:OJIFUR@192.168.1.91:554/ch1/main";
        terminal = false;
        categories = ["Application"];
      };
      Jellyfin = {
        name = "Jellyfin";
        type = "Link";
        settings.URL = "http://nas.local:8096/";
      };
      */
    };
  };
}
