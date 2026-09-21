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
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    clan-core.url = "git+https://git.clan.lol/clan/clan-core";
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      #inputs.nixpkgs.follows = "clan-core/nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankcalendar = {
      url = "github:AvengeMedia/dankcalendar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    funkuino = {
      url = "github:tbaumann/Funkuino";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    github-actions-nix.url = "github:synapdeck/github-actions-nix";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    ghostty-shaders = {
      url = "github:hackr-sh/ghostty-shaders";
      flake = false;
    };
    graphite.url = "github:GraphiteEditor/Graphite/";
    home-manager = {
      #url = "github:nix-community/home-manager/release-26.05";
      url = "github:nix-community/home-manager/";
      #inputs.nixpkgs.follows = "clan-core/nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    iio-sway.url = "github:tbaumann/iio-sway";
    llm-agents.url = "github:numtide/llm-agents.nix";
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # moltis.url = "github:tbaumann/moltis";
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-topology = {
      url = "github:oddlama/nix-topology";
      inputs.nixpkgs.follows = "clan-core/nixpkgs";
    };
    /*
      nixos-generators = {
        url = "github:nix-community/nixos-generators";
        inputs.nixpkgs.follows = "clan-core/nixpkgs";
      };
    */
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-sbc.url = "github:nakato/nixos-sbc/main";
    niri-flake = {
      url = "github:sodiboo/niri-flake/";
      inputs.nixpkgs.follows = "clan-core/nixpkgs"; # optional
    };
    nvf.url = "github:notashelf/nvf/";
    omp.url = "github:can1357/oh-my-pi";
    preservation.url = "github:nix-community/preservation";
    hermes-agent = {
      #url = "github:tbaumann/hermes-agent/fix/issue-43810-filter-extraPythonPackages-deps";
      url = "github:NousResearch/hermes-agent";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vpn-confinement.url = "github:Maroka-chan/VPN-Confinement";
    stylix.url = "github:danth/stylix/release-26.05";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    ucodenix.url = "github:e-tho/ucodenix/";
    update-systemd-resolved = {
      url = "github:jonathanio/update-systemd-resolved";
      inputs.nixpkgs.follows = "clan-core/nixpkgs"; # optional
    };
    vireo.url = "github:tbaumann/vireo";
    waybar_media_display.url = "github:tbaumann/waybar_media_display";
    waybar_weather_display.url = "github:tbaumann/waybar_weather_display";
    wpaperd = {
      url = "github:Narice/wpaperd";
      inputs.nixpkgs.follows = "clan-core/nixpkgs";
    };
    win98se-plymouth.url = "github:nilp0inter/plymouth-theme-win98se-inspired-nixos-theme";
    cinephage.url = "github:MoldyTaint/Cinephage";
    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  nixConfig = {
    netrc-file = "/run/secrets/netrc";
    #post-build-hook = "./scripts/push-to-nix-ci-cache";
    post-build-hook = "/run/current-system/sw/bin/push-to-nix-ci-cache";
    extra-substituters = "https://cache.nix-ci.com";
    extra-trusted-public-keys = "nix-ci:g3xV5BDTLtIBZr/A00IU1x0EtKKlb7YLgBN2SgYgM6A=";
  };
  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { ... }: {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          #"x86_64-darwin"
          #"aarch64-darwin"
        ];

        imports = [
          inputs.git-hooks-nix.flakeModule
          inputs.github-actions-nix.flakeModules.default
          inputs.treefmt-nix.flakeModule
          inputs.home-manager.flakeModules.home-manager
          ./actions.nix
          ./clan.nix
          ./checks.nix
          ./devshells.nix
          ./hooks.nix
          ./pkgs.nix
          ./topology.nix
        ];
        flake.homeModules.common = {
          imports = [
            ./home-manager/common.nix
          ];
        };
        /*
          flake.homeConfigurations.tilli = inputs.home-manager.lib.homeManagerConfiguration {
            # pkgs = import nixpkgs { system = "x86_64-linux"; };
            pkgs = self.x86_64-linux.packages;
            modules = [
              inputs.self.homeModules.common
              ./home-manager/tilli.nix
            ];
          };
        */
      }
    );
}
