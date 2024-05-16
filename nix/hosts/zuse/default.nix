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
  ];

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
    package = pkgs.openrgb-with-all-plugins;
  };
  programs.coolercontrol.enable = true;
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 2048; # Use 2048MiB memory.
      cores = 3;
    };
  };
  boot.extraModulePackages = with config.boot.kernelPackages; [liquidtux];
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
