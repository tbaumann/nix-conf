{
  pkgs,
  lib,
  config,
  ...
}:
{
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
  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    extraModulePackages = with config.boot.kernelPackages; [ liquidtux ];

    extraModprobeConfig = "options kvm_amd nested=1";
  };
  environment.systemPackages = with pkgs; [
    liquidctl
  ];
  networking = {
    useNetworkd = lib.mkForce true;
    hostName = "zuse";
  };

  services = {
    k3s.enable = true;
    btrfs.autoScrub.enable = true;
    hardware.openrgb = {
      enable = true;
      motherboard = "amd";
    };
    pcscd = {
      enable = true;
      plugins = [ pkgs.pcsc-cyberjack ];
    };
  };
  programs.coolercontrol.enable = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
