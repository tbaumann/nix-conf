{ inputs, withSystem, ... }: {
  flake.homeConfigurations.tilli = withSystem "x86_64-linux" (
    { pkgs, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [
        inputs.iio-sway.homeManagerModules.default
        inputs.nix-index-database.homeModules.nix-index
        inputs.nvf.homeManagerModules.default
        inputs.stylix.homeModules.stylix
        inputs.self.homeModules.common
        ./home-manager/tilli.nix
      ];
    }
  );
}
