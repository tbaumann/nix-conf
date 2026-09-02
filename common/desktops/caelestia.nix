{ inputs, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    inputs.celestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli
  ];
}
