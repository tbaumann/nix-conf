{inputs, ...}: {
  imports = with inputs; [
    nixos-sbc.nixosModules.default
    nixos-sbc.nixosModules.boards.raspberrypi.rpi4
  ];
  sbc.version = "0.3";
  nixpkgs.hostPlatform = "aarch64-linux";
}
