{inputs, ...}: {
  imports = with inputs; [
    update-systemd-resolved.nixosModules.update-systemd-resolved
    stylix.nixosModules.stylix
    base16.nixosModule
    nix-index-database.nixosModules.nix-index
    nvf.nixosModules.default
    microvm.nixosModules.host
    nixos-sbc.nixosModules.cache
    nix-topology.nixosModules.default
    ucodenix.nixosModules.default
    home-manager.nixosModules.home-manager
    {
      home-manager.backupFileExtension = "hm.bak";
      home-manager.sharedModules = [
        iio-sway.homeManagerModules.default
        nix-index-database.homeModules.nix-index
        nix-openclaw.homeManagerModules.openclaw
        nvf.homeManagerModules.default
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
