{
  inputs,
  config,
  pkgs,
  environment,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    #    ../../common/core.nix
  ];

  networking.hostName = "nas";
  system.stateVersion = "23.05"; # Did you read the comment?
}
