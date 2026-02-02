{
  inputs,
  ...
}:
{
  imports = with inputs; [
    update-systemd-resolved.nixosModules.update-systemd-resolved
    nix-flatpak.nixosModules.nix-flatpak
    stylix.nixosModules.stylix
    base16.nixosModule
    nix-index-database.nixosModules.nix-index
    nvf.nixosModules.default
    microvm.nixosModules.host
    nixos-sbc.nixosModules.cache
    nix-topology.nixosModules.default
    #niri-flake.nixosModules.niri
    ucodenix.nixosModules.default
    home-manager.nixosModules.home-manager
    {
      home-manager.backupFileExtension = "hm.bak";
      home-manager.sharedModules = [
        nix-index-database.homeModules.nix-index
        nix-flatpak.homeManagerModules.nix-flatpak
        #niri-flake.homeModules.niri
        nvf.homeManagerModules.default
        iio-sway.homeManagerModules.default
        stylix.homeModules.stylix
      ];
      home-manager.extraSpecialArgs = {
        inherit inputs;
      };
    }
  ];

  # Locale service discovery and mDNS
  services.avahi.enable = true;
}
