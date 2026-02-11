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
    files.token.secret = true;
    script = ''
      pwgen -c -n 64 1 > $out/token
    '';
    runtimeInputs = [pkgs.pwgen];
  };
  clan.core.vars.generators.anthropic-token = {
    share = true;
    prompts.token.description = "Anthropic token";
    prompts.token.type = "line";
    files.token.secret = true;
    script = ''
      cp $prompts/* > $out/
    '';
  };
  nixpkgs.overlays = [inputs.nix-openclaw.overlays.default];
  services.openclaw = {
    enable = true;
    providers.anthropic = {
      oauthTokenFile = config.clan.core.vars.generators.anthropic-token.files.token.path;
    };
    instances.default = {
      gateway.auth.tokenFile = config.clan.core.vars.generators.openclaw-token.files.token.path;
    };
  };

  services.openssh.enable = true;
  sbc.version = "0.3";
  networking.useNetworkd = lib.mkForce true;
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = "aarch64-linux";
}
