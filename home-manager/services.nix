{
  pkgs,
  config,
  ...
}: {
  services = {
    poweralertd.enable = true;
    udiskie = {
      enable = false;
      automount = true;
      notify = true;
    };
    mako = {
      enable = true;
      settings = {
        border-radius = 5;
        border-size = 2;
        layer = "overlay";
        default-timeout = 5000;
      };
    };
    flameshot = {
      enable = true;
      settings = {
        General = {
          savePath = "/home/tilli/Downloads/";
          savePathFixed = false;

          disabledTrayIcon = false;
          showDesktopNotification = true;
          showHelp = true;
        };
      };
    };
  };
}
