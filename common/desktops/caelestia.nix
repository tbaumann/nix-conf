{ inputs, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli
  ];
}
