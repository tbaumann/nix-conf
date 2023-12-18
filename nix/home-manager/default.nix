{
  colors,
  inputs,
  ...
}: {
  imports = [
#    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      tilli = {...}: {
        imports = [
          ./tilli.nix
          ./common.nix
        ];
      };
      chaimae = {...}: {
        imports = [
          ./common.nix
          ./chaimae.nix
        ];
      };
    };
    extraSpecialArgs = {
      inherit colors;
      inherit inputs;
    };
  };
}
