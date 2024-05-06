{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [inputs.nix-alien.overlays.default];
  environment.systemPackages = with pkgs; [
    nix-alien
  ];
  # Optional, needed for `nix-alien-ld`
  #  programs.nix-ld.enable = true;
}
