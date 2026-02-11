{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = with inputs; [
    nixos-sbc.nixosModules.default
    nixos-sbc.nixosModules.boards.raspberrypi.rpi4
    #clan-core.nixosModules.installer
    nix-openclaw.nixosModules.openclaw
    ../../modules/shared.nix
    ../../common/user-group.nix
  ];
  clan.core.vars.generators.openclaw-token = {
    files.token.name = "token";
    files.token.secret = true;
    script = ''
      pwgen -c -n 64 1 > $out/token
    '';
    runtimeInputs = [pkgs.pwgen];
  };
  services.openclaw = {
    enable = true;
    providers.anthropic = {
      oauthTokenFile = config.sops.secrets.anthropic-token.path;
    };
    instances.default = {
      gateway.auth.tokenFile = config.clan.core.vars.generators.openclaw-token.files.token.path;
    };
  };

  sbc.version = "0.3";
  networking.useNetworkd = lib.mkForce true;
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = "aarch64-linux";
}
