{ inputs, ... }: {
  imports = [
  ];

  transposition.nixidyEnvs.adHoc = true;

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      nixidyEnvs = inputs.nixidy.lib.mkEnvs {
        inherit pkgs;
        envs = {
          home.modules = [ ./nixidy/home ];
          nuc.modules = [ ./nixidy/nuc ];
        };
      };
    };
}
