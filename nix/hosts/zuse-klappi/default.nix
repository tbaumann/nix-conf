{
  inputs,
  config,
  pkgs,
  environment,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    #    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ../../common/core.nix
    ../../common/core-desktop.nix
    ../../common/laptop.nix
  ];
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 2048; # Use 2048MiB memory.
      cores = 3;
    };
  };
  boot.extraModulePackages = with config.boot.kernelPackages; [liquidtux];
  networking.hostName = "zuse-klappi";
  system.stateVersion = "23.05"; # Did you read the comment?
}
