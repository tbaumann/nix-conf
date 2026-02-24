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
  boot = {
    binfmt.emulatedSystems = ["aarch64-linux"];
    #    extraModulePackages = with config.boot.kernelPackages; [liquidtux];

    extraModprobeConfig = "options kvm_amd nested=1";
  };
  environment.systemPackages = with pkgs; [
    liquidctl
  ];
  networking = {
    useNetworkd = lib.mkForce true;
    hostName = "zuse";
    nat = {
      enable = true;
      internalInterfaces = ["microbr"];
      externalInterface = "enp69s0";
    };
  };
  systemd.network = {
    netdevs."20-microbr".netdevConfig = {
      Kind = "bridge";
      Name = "microbr";
    };

    networks = {
      "20-microbr" = {
        matchConfig.Name = "microbr";
        addresses = [{Address = "192.168.83.1/24";}];
        networkConfig = {
          ConfigureWithoutCarrier = true;
        };
      };

      "21-microvm-tap" = {
        matchConfig.Name = "microvm*";
        networkConfig.Bridge = "microbr";
      };
    };
  };

  services = {
    btrfs.autoScrub.enable = true;
    hardware.openrgb = {
      enable = true;
      motherboard = "amd";
    };
    pcscd = {
      enable = true;
      plugins = [pkgs.pcsc-cyberjack];
    };
  };
  programs.coolercontrol.enable = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
