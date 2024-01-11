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

    (inputs.nixpkgs-coolercontrol + "/nixos/modules/programs/coolercontrol.nix")

    ./hardware-configuration.nix
    ../../common/core.nix
  ];

  # virtualisation.incus.enable = true;

  nixpkgs.overlays = [
    (self: super: {
      coolercontrol = lib.recurseIntoAttrs (super.callPackage (inputs.nixpkgs-coolercontrol + /pkgs/applications/system/coolercontrol) {});
    })
  ];
  programs.coolercontrol.enable = true;
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 2048; # Use 2048MiB memory.
      cores = 3;
    };
  };
  boot.extraModulePackages = with config.boot.kernelPackages; [liquidtux];
  environment.systemPackages = with pkgs; [
    liquidctl
  ];
  services.hardware.openrgb.enable = true;
  hardware.gkraken.enable = true;
  hardware.openrazer.enable = true;
  hardware.openrazer.users = ["tilli"];
  networking.hostName = "zuse";
  system.stateVersion = "23.05"; # Did you read the comment?
}
