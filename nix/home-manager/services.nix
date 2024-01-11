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
      borderRadius = 5;
      borderSize = 2;
      layer = "overlay";
      defaultTimeout = 5000;
    };
  };
}
