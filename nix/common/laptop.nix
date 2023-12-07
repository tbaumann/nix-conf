{
  inputs,
  config,
  pkgs,
  environment,
  ...
}: {
  imports = [
  ];
  hardware.bluetooth.enable = true;

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
    auto-cpufreq.enable = true;
    auto-cpufreq.settings = {
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
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
