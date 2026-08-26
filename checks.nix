{ self, ... }: {
  imports = [
  ];
  perSystem = {
    checks = {
      zuse-toplevel = self.nixosConfigurations.zuse.config.system.build.toplevel;
      zuse-klappi-toplevel = self.nixosConfigurations.zuse.config.system.build.toplevel;
    };
  };
}
