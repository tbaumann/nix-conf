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
    ../../common/core-pc.nix
    ../../common/laptop.nix
  ];
  topology.self = {
    hardware.info = "DELL XPS";
    interfaces.wlan0 = {
      network = "home"; # Use the network we define below
    };
  };

  #use the big box
  nix.distributedBuilds = true;
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 2048; # Use 2048MiB memory.
      cores = 3;
    };
  };
  networking.hostName = "zuse-klappi";
  system.stateVersion = "23.05"; # Did you read the comment?
}
