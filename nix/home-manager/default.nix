{
inputs,
  ...
}: {
  imports = [
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
  };
}
