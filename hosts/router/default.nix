{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
     ../../common/core.nix
    ./hardware.nix
  ];

  system.etc.overlay.enable = lib.mkForce false; #FIXME erofs not available on vendor kernel
  systemd.sysusers.enable = false; #FIXME https://github.com/ryantm/agenix/issues/238
  boot.initrd.systemd.enable = lib.mkForce false;

  topology.self = {
    name = "router";
    hardware.info = "BananaPi R4";
    interfaces.wan1 = {
    };
    interfaces.eno1 = {
      addresses = ["192.168.1.1"];
      network = "home"; # Use the network we define below
    };
  };
  documentation.enable = false;
  documentation.man.enable = false;
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.hostPlatform.system = "aarch64-linux";
  #nixpkgs.buildPlatform.system = "x86_64-linux";

  #environment.noXlibs = true;

  users.users.example = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "24.05";
}
