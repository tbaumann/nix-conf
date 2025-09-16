{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ../../modules/shared.nix
    ../../common/core.nix
    ../../common/core-desktop.nix
    ../../common/core-pc.nix
  ];
  topology.self = {
    hardware.info = "DELL XPS";
    interfaces.wlan0 = {
      network = "home"; # Use the network we define below
    };
  };
  #systemd.network.wait-online.enable = lib.mkForce true;
  networking.useNetworkd = lib.mkForce true;

  #use the big box
  nix.distributedBuilds = true;
  networking.hostName = "zuse-klappi";
}
