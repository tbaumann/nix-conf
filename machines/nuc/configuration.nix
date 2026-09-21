{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/shared.nix
    ../../common/core.nix

  ];
  system.etc.overlay.enable = true;
  system.nixos-init.enable = lib.mkForce false;
  systemd.oomd.enable = true;
  documentation.enable = false;
  documentation.man.enable = false;
  services.openssh.enable = true;
  networking.useNetworkd = lib.mkForce true;
  networking.useDHCP = lib.mkDefault true;

  # New machine!
}
