{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = with inputs; [
    nixos-sbc.nixosModules.default
    nixos-sbc.nixosModules.boards.raspberrypi.rpi4
    ../../modules/shared.nix
    ../../common/core.nix
    ../../common/tailscale.nix
  ];
  system.etc.overlay.enable = true;
  #boot.initrd.systemd.enable = true;
  system.nixos-init.enable = lib.mkForce false;
  systemd.oomd.enable = true;
  documentation.enable = false;
  documentation.man.enable = false;
  environment.systemPackages = with pkgs; [
    bat
    jq
  ];

  services.openssh.enable = true;
  services.k3s = {
    enable = true;
    extraFlags = [
      "--write-kubeconfig-group=wheel"
      "--write-kubeconfig-mode=640"
    ];
  };
  sbc.version = "0.3";
  networking.useNetworkd = lib.mkForce true;
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = "aarch64-linux";
}
