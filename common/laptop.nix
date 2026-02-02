{
  pkgs,
  lib,
  ...
}:
{
  imports = [
  ];
  hardware.bluetooth.enable = true;
  hardware.sensor.iio.enable = true;

  services = {
    blueman.enable = true;
    fprintd.enable = true;
    upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 2;
      criticalPowerAction = "PowerOff";
    };
    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 60;
        STOP_CHARGE_THRESH_BAT0 = 90;
      };
    };
    power-profiles-daemon.enable = lib.mkForce false;
    automatic-timezoned.enable = true;
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };
  time.timeZone = lib.mkForce null;
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
