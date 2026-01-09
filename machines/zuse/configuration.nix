{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    ../../modules/shared.nix

    ../../common/core.nix
    ../../common/core-desktop.nix
    ../../common/core-pc.nix
    ./hardware-configuration.nix
  ];
  topology.self = {
    hardware.info = "24 core Threadripper workstation";
    interfaces.eno1 = {
      network = "home"; # Use the network we define below
    };
  };
  networking.useNetworkd = lib.mkForce true;
  networking.hostName = "zuse";

  services.k3s.enable = true;

  # BTRFS stuff
  services.btrfs.autoScrub.enable = true;

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };
  programs.coolercontrol.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [liquidtux];

  boot.extraModprobeConfig = "options kvm_amd nested=1";
  environment.systemPackages = with pkgs; [
    liquidctl
  ];
  services.pcscd = {
    enable = true;
    plugins = [pkgs.pcsc-cyberjack];
  };
  boot.binfmt.emulatedSystems = ["aarch64-linux"];
  system.stateVersion = "23.05"; # Did you read the comment?
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
