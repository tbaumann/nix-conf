{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./git.nix
  ];

  programs = {
    #    git.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    fish.enable = true;
    less.enable = true;
    nix-ld.enable = true;
    npm.enable = true;
    steam.enable = false;
  };
  stylix.targets.fish.enable = false;
  services = {
    boinc.enable = false;
  };
}
