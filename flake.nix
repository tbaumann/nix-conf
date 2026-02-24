{
  description = "My flake for everything";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    argon40-nix.url = "github:guusvanmeerveld/argon40-nix";
    base16.url = "github:SenchoPens/base16.nix";
    catppuccin-fish = {
      url = "github:catppuccin/fish";
      flake = false;
    };
    catppuccin-foot = {
      url = "github:catppuccin/foot";
      flake = false;
    };
    catppuccin-i3 = {
      url = "github:catppuccin/i3";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
    clan-core.url = "git+https://git.clan.lol/clan/clan-core";
    # nixpkgs.follows = "clan-core/nixpkgs";
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      #inputs.nixpkgs.follows = "clan-core/nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    ghostty-shaders = {
      url = "github:hackr-sh/ghostty-shaders";
      flake = false;
    };
    graphite.url = "github:GraphiteEditor/Graphite/?dir=.nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      #url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "clan-core/nixpkgs";
    };
    iio-sway.url = "github:tbaumann/iio-sway";
    llm-agents.url = "github:numtide/llm-agents.nix";
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-topology = {
      url = "github:oddlama/nix-topology";
      inputs.nixpkgs.follows = "clan-core/nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "clan-core/nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-sbc.url = "github:nakato/nixos-sbc/main";
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "clan-core/nixpkgs"; # optional
    };
    nvf.url = "github:notashelf/nvf/";
    vpn-confinement.url = "github:Maroka-chan/VPN-Confinement";
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "clan-core/nixpkgs";
    };
    stylix.url = "github:danth/stylix/";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    ucodenix.url = "github:e-tho/ucodenix";
    update-systemd-resolved = {
      url = "github:jonathanio/update-systemd-resolved";
      inputs.nixpkgs.follows = "clan-core/nixpkgs"; # optional
    };
    waybar_media_display.url = "github:tbaumann/waybar_media_display";
    waybar_weather_display.url = "github:tbaumann/waybar_weather_display";
    wpaperd = {
      url = "github:Narice/wpaperd";
      inputs.nixpkgs.follows = "clan-core/nixpkgs";
    };
    cinephage.url = "github:MoldyTaint/Cinephage";
    # felschr.url = "git+https://git.felschr.com/felschr/nixos-config.git";
  };
  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} (
      {...}: {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          #"x86_64-darwin"
          #"aarch64-darwin"
        ];

        imports = [
          inputs.git-hooks-nix.flakeModule
          inputs.treefmt-nix.flakeModule
          ./clan.nix
          ./devshells.nix
          ./hooks.nix
          ./pkgs.nix
          ./topology.nix
        ];
      }
    );
}
