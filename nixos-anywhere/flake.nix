{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { nixpkgs, disko, ... }:
    {
      nixosConfigurations.zuse-klappi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
           { disko.devices.disk.disk1.device = "/dev/nvme0n1";}
          ./configuration.nix
        ];
      };
    };
}
