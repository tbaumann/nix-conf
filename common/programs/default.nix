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
    mosh.enable = true;
    mtr.enable = true;
    iotop.enable = true;
  };
  stylix.targets.fish.enable = false;
  services = {
    boinc.enable = false;
  };
}
