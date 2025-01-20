{
  config,
  pkgs,
  ...
}:
{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    restic
  ];

  # Backups
  services.restic.backups = {
    rsync_net = {
      passwordFile = config.age.secrets.restic-password.path;
      paths = [
        "/home/tilli/"
        "/home/chaimae/"
      ];
      extraBackupArgs = [
        "--tag home"
        "--tag nixos"
        "--verbose"
      ];
      repository = "sftp:zh3470@zh3470.rsync.net:restic-repo";
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
        "--keep-yearly 2"
        "--keep-tag archive"
      ];
      exclude = [
        "/home/tilli/.mozilla/firefox/*/cache2"
        "/home/tilli/.mozilla/firefox/*/OfflineCache"
        "/home/tilli/.mozilla/firefox/*/safebrowsing"
        "/home/tilli/.mozilla/firefox/*/startupCache"
        "/home/tilli/.mozilla/firefox/*/thumbnails"
        "/home/tilli/.mozilla/firefox/*/bookmarkbackups"
        "/home/tilli/.mozilla/firefox/*/sessionstore-backups"
        "/home/tilli/.cache/*"
        "/home/tilli/.local/share/Trash/*"
        "/home/tilli/.rescript/lock/*"
        "/home/tilli/.gvfs"
        "/home/tilli/.dbus"
        "/home/tilli/.local/share/gvfs-metadata"
        "/home/tilli/.Private"
        "/home/tilli/.Trash"
        "/home/tilli/.cddb"
        "/home/tilli/.aptitude"
        "/home/tilli/.adobe"
        "/home/tilli/.bash_history"
        "/home/tilli/.dropbox"
        "/home/tilli/.dropbox-dist"
        "/home/tilli/.macromedia"
        "/home/tilli/.xsession-errors"
        "/home/tilli/.recently-used"
        "/home/tilli/.recently-used.xbel"
        "/home/tilli/.local/share/recently-used*"
        "/home/tilli/.thumbnails/*"
        "/home/tilli/.Xauthority"
        "/home/tilli/.ICEauthority"
        "/home/tilli/.gksu.lock"
        "/home/tilli/.pulse"
        "/home/tilli/.pulse-cookie"
        "/home/tilli/.esd_auth"
        "/home/tilli/.ecryptfs"
        "/home/tilli/.opera"
        "/home/tilli/.npm"
        "/home/tilli/.gnupg/rnd"
        "/home/tilli/.gnupg/random_seed"
        "/home/tilli/.gnupg/.#*"
        "/home/tilli/.gnupg/*.lock"
        "/home/tilli/.gnupg/gpg-agent-info-*"
        "/home/tilli/.config/**/Cache"
        "/home/tilli/.config/**/GPUCache"
        "/home/tilli/.config/**/ShaderCache"
        "/home/tilli/snap/**/.config/**/Cache"
        "/home/tilli/snap/**/.config/**/GPUCache"
        "/home/tilli/snap/**/.config/**/ShaderCache"
        "/home/tilli/Downloads"
        "*.lock"
        "*.bak"
        "*.backup"
        "*.backup*"
        "*~"
        "/home/tilli/restic"
        "/home/tilli/cache"
        "/home/tilli/snap"
        "/home/tilli/Backup"
        "*.cache"
        "/home/tilli/**/Cache"
        "/home/tilli/**/cache"
        "/home/tilli/**/temp"
        "/home/tilli/**/tmp"
        "/home/tilli/Data"
        "/home/tilli/go"
        "/home/tilli/zephyrproject"
        "*.git"
        "/home/tilli/.local"
        "/home/tilli/.platformio "
        "/home/tilli/.cargo"
        "/home/tilli/.espressif "
        "/home/tilli/.pyenv"
        "/home/tilli/.gradle"
        "/home/tilli/.virtualenvs"
        "/home/tilli/.var"
        "/home/tilli/Android"
        ".pio"
        "/home/tilli/.vscode/extensions "
        "/home/tilli/esp"
        "#/home/tilli/Music"
        "/home/tilli/.mozilla/firefox/**/storage "
        "/home/tilli/.mozilla/firefox/**/minidumps"
        "/home/tilli/git/uhernfr/powerdns-docker/mysql-data"
        "node_modules"
        "/home/chaimae/.mozilla/firefox/*/cache2"
        "/home/chaimae/.mozilla/firefox/*/OfflineCache"
        "/home/chaimae/.mozilla/firefox/*/safebrowsing"
        "/home/chaimae/.mozilla/firefox/*/startupCache"
        "/home/chaimae/.mozilla/firefox/*/thumbnails"
        "/home/chaimae/.mozilla/firefox/*/bookmarkbackups"
        "/home/chaimae/.mozilla/firefox/*/sessionstore-backups"
        "/home/chaimae/.cache/*"
        "/home/chaimae/.local/share/Trash/*"
        "/home/chaimae/.rescript/lock/*"
        "/home/chaimae/.gvfs"
        "/home/chaimae/.dbus"
        "/home/chaimae/.local/share/gvfs-metadata"
        "/home/chaimae/restic"
        "/home/chaimae/cache"
        "/home/chaimae/Backup"
      ];
    };
    nas = {
      passwordFile = config.age.secrets.restic-password.path;
      paths = [
        "/home/tilli/"
        "/home/chaimae/"
      ];
      extraBackupArgs = [
        "--tag home"
        "--tag nixos"
        "--verbose"
      ];
      repository = "rest:http://tilli@nas.local:8000/";
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
        "--keep-yearly 2"
        "--keep-tag archive"
      ];
      exclude = [
        "/home/tilli/.mozilla/firefox/*/cache2"
        "/home/tilli/.mozilla/firefox/*/OfflineCache"
        "/home/tilli/.mozilla/firefox/*/safebrowsing"
        "/home/tilli/.mozilla/firefox/*/startupCache"
        "/home/tilli/.mozilla/firefox/*/thumbnails"
        "/home/tilli/.mozilla/firefox/*/bookmarkbackups"
        "/home/tilli/.mozilla/firefox/*/sessionstore-backups"
        "/home/tilli/.cache/*"
        "/home/tilli/.local/share/Trash/*"
        "/home/tilli/.rescript/lock/*"
        "/home/tilli/.gvfs"
        "/home/tilli/.dbus"
        "/home/tilli/.local/share/gvfs-metadata"
        "/home/tilli/.Private"
        "/home/tilli/.Trash"
        "/home/tilli/.cddb"
        "/home/tilli/.aptitude"
        "/home/tilli/.adobe"
        "/home/tilli/.bash_history"
        "/home/tilli/.dropbox"
        "/home/tilli/.dropbox-dist"
        "/home/tilli/.macromedia"
        "/home/tilli/.xsession-errors"
        "/home/tilli/.recently-used"
        "/home/tilli/.recently-used.xbel"
        "/home/tilli/.local/share/recently-used*"
        "/home/tilli/.thumbnails/*"
        "/home/tilli/.Xauthority"
        "/home/tilli/.ICEauthority"
        "/home/tilli/.gksu.lock"
        "/home/tilli/.pulse"
        "/home/tilli/.pulse-cookie"
        "/home/tilli/.esd_auth"
        "/home/tilli/.ecryptfs"
        "/home/tilli/.opera"
        "/home/tilli/.npm"
        "/home/tilli/.gnupg/rnd"
        "/home/tilli/.gnupg/random_seed"
        "/home/tilli/.gnupg/.#*"
        "/home/tilli/.gnupg/*.lock"
        "/home/tilli/.gnupg/gpg-agent-info-*"
        "/home/tilli/.config/**/Cache"
        "/home/tilli/.config/**/GPUCache"
        "/home/tilli/.config/**/ShaderCache"
        "/home/tilli/snap/**/.config/**/Cache"
        "/home/tilli/snap/**/.config/**/GPUCache"
        "/home/tilli/snap/**/.config/**/ShaderCache"
        "/home/tilli/Downloads"
        "*.lock"
        "*.bak"
        "*.backup"
        "*.backup*"
        "*~"
        "/home/tilli/restic"
        "/home/tilli/cache"
        "/home/tilli/snap"
        "/home/tilli/Backup"
        "*.cache"
        "/home/tilli/**/Cache"
        "/home/tilli/**/cache"
        "/home/tilli/**/temp"
        "/home/tilli/**/tmp"
        "/home/tilli/Data"
        "/home/tilli/go"
        "/home/tilli/zephyrproject"
        "*.git"
        "/home/tilli/.local"
        "/home/tilli/.platformio "
        "/home/tilli/.cargo"
        "/home/tilli/.espressif "
        "/home/tilli/.pyenv"
        "/home/tilli/.gradle"
        "/home/tilli/.virtualenvs"
        "/home/tilli/.var"
        "/home/tilli/Android"
        ".pio"
        "/home/tilli/.vscode/extensions "
        "/home/tilli/esp"
        "#/home/tilli/Music"
        "/home/tilli/.mozilla/firefox/**/storage "
        "/home/tilli/.mozilla/firefox/**/minidumps"
        "/home/tilli/git/uhernfr/powerdns-docker/mysql-data"
        "node_modules"
        "/home/chaimae/.mozilla/firefox/*/cache2"
        "/home/chaimae/.mozilla/firefox/*/OfflineCache"
        "/home/chaimae/.mozilla/firefox/*/safebrowsing"
        "/home/chaimae/.mozilla/firefox/*/startupCache"
        "/home/chaimae/.mozilla/firefox/*/thumbnails"
        "/home/chaimae/.mozilla/firefox/*/bookmarkbackups"
        "/home/chaimae/.mozilla/firefox/*/sessionstore-backups"
        "/home/chaimae/.cache/*"
        "/home/chaimae/.local/share/Trash/*"
        "/home/chaimae/.rescript/lock/*"
        "/home/chaimae/.gvfs"
        "/home/chaimae/.dbus"
        "/home/chaimae/.local/share/gvfs-metadata"
        "/home/chaimae/restic"
        "/home/chaimae/cache"
        "/home/chaimae/Backup"
      ];
    };
  };
  services.prometheus.exporters.restic = {
    enable = true;
    repository = "${config.services.restic.backups.rsync_net.repository}";
    passwordFile = "${config.services.restic.backups.rsync_net.passwordFile}";
  };
}
