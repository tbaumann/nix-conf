{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/shared.nix

    ../../common/core.nix
    ../../common/core-desktop.nix
    ../../common/core-pc.nix
  ];
  topology.self = {
    hardware.info = "24 core Threadripper workstation";
    interfaces.eno1 = {
      network = "home"; # Use the network we define below
    };
  };
  networking.useNetworkd = lib.mkForce true;

  # BTRFS stuff
  services.btrfs.autoScrub.enable = true;
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };
  programs.coolercontrol.enable = true;
  # FIXME broken boot.extraModulePackages = with config.boot.kernelPackages; [liquidtux];
  boot.extraModprobeConfig = "options kvm_amd nested=1";
  environment.systemPackages = with pkgs; [
    liquidctl
  ];
  #  hardware.openrazer.enable = true;
  #  hardware.openrazer.users = ["tilli"];
  networking.hostName = "zuse";
  system.stateVersion = "23.05"; # Did you read the comment?
}
