
{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [ (pkgs.buildEnv { name = "my-scripts"; paths = [ ./scripts ]; }) ];
}
