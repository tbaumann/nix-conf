{
  inputs,
  config,
  pkgs,
  environment,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ../../common/core.nix
    ../../common/core-desktop.nix
    ../../common/core-pc.nix
  ];
  /*
  shb.arr = {
    sonarr.enable = true;
    sonarr.settings.ApiKey.source = config.age.secrets.arr-api-key.path;
    sonarr.subdomain = "radarr";
    sonarr.domain = "rak.baumann.ma";
  };
  users.groups.media = {};
  shb.monitoring = {
    enable = true;
    subdomain = "grafana";
    domain = "rak.baumann.ma";
    contactPoints = [ "tilman.baumann@tilman.baumann.name" ];
    lokiMajorVersion = 3;
   # adminPassword = config.age.secrets.grafana-password;
   # secretKey = config.age.secrets.grafana-secret;
  };
  */
  topology.self = {
    hardware.info = "24 core Threadripper workstation";
    interfaces.eno1 = {
      network = "home"; # Use the network we define below
    };
  };

  services.esphome.enable = true;
  # BTRFS stuff
  services.btrfs.autoScrub.enable = true;
  services.beesd.filesystems = {
    root = {
      spec = "/nix/";
      extraOptions = ["--loadavg-target" "3.0"];
    };
  };
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    package = pkgs.openrgb;
  };
  programs.coolercontrol.enable = true;
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 2048; # Use 2048MiB memory.
      cores = 3;
    };
  };
  # FIXME broken boot.extraModulePackages = with config.boot.kernelPackages; [liquidtux];
  boot.extraModprobeConfig = "options kvm_amd nested=1";
  environment.systemPackages = with pkgs; [
    liquidctl
  ];
  #  hardware.gkraken.enable = true;
  #  hardware.openrazer.enable = true;
  #  hardware.openrazer.users = ["tilli"];
  networking.hostName = "zuse";
  system.stateVersion = "23.05"; # Did you read the comment?
}
