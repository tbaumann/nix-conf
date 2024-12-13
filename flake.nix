{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    update-systemd-resolved = {
      url = "github:jonathanio/update-systemd-resolved";
      inputs.nixpkgs.follows = "nixpkgs"; # optional
    };
    stylix.url = "github:danth/stylix/d13ffb381c83b6139b9d67feff7addf18f8408fe";
    base16.url = "github:SenchoPens/base16.nix";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";

      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-networkmanager-profiles = {
      url = "github:jmackie/nixos-networkmanager-profiles";
      flake = false;
    };
    ragenix = {
      #url = "github:ryantm/agenix";
      url = "github:yaxitech/ragenix/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";

    # anyrun - a wayland launcher
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    wpaperd = {
      url = "github:Narice/wpaperd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";

      inputs.nixpkgs.follows = "nixpkgs";
    };
    # AstroNvim is an aesthetic and feature-rich neovim config.
    astronvim = {
      url = "github:AstroNvim/AstroNvim/v3.37.8";
      flake = false;
    };
    khanelivim.url = "github:tbaumann/khanelivim";
    /*
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    */
    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";

    waybar_weather_display.url = "github:tbaumann/waybar_weather_display";
    waybar_media_display.url = "github:tbaumann/waybar_media_display";
    #    nixvim-config.url = "github:mikaelfangel/nixvim-config";
    nixvim-kickstart = {
      url = "github:JMartJonesy/kickstart.nixvim";
      flake = false;
    };

    nixarr.url = "github:rasmus-kirk/nixarr";
    # argon40-nix.url = "github:guusvanmeerveld/argon40-nix";
    argon40-nix.url = "/home/tilli/git/argon40-nix";

    ucodenix.url = "github:e-tho/ucodenix";

    # color scheme - catppuccin
    catppuccin-i3 = {
      url = "github:catppuccin/i3";
      flake = false;
    };
    catppuccin-foot = {
      url = "github:catppuccin/foot";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
    catppuccin-fish = {
      url = "github:catppuccin/fish";
      flake = false;
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-sbc.url = "github:nakato/nixos-sbc/main";

    impermanence.url = "github:nix-community/impermanence";
    niri-flake.url = "github:sodiboo/niri-flake";
    ghostty.url = "github:clo4/ghostty-hm-module";

    nix-topology.url = "github:oddlama/nix-topology";
    nix-topology.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    selfhostblocks.url = "github:ibizaman/selfhostblocks";
  };
  outputs = {
    self,
    base16,
    flake-parts,
    ghostty,
    home-manager,
    impermanence,
    microvm,
    niri-flake,
    nix-flatpak,
    nix-index-database,
    nix-topology,
    nixarr,
    nixos-hardware,
    nixos-sbc,
    nixpkgs,
    nixpkgs-unstable,
    nixvim,
    ragenix,
    selfhostblocks,
    stylix,
    ucodenix,
    update-systemd-resolved,
    waybar_media_display,
    waybar_weather_display,
    wpaperd,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {
      #inherit system;
      overlays = [nix-topology.overlays.default];
    };
    mkNixosConfiguration = {
      baseModules ? [
        ./common/secrets.nix
        ragenix.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
        update-systemd-resolved.nixosModules.update-systemd-resolved
        stylix.nixosModules.stylix
        base16.nixosModule
        nix-index-database.nixosModules.nix-index
        #nixvim.nixosModules.nixvim
        #selfhostblocks.nixosModules.${system}.default
        #auto-cpufreq.nixosModules.default
        microvm.nixosModules.host
        nixos-sbc.nixosModules.cache
        nix-topology.nixosModules.default
        niri-flake.nixosModules.niri
        ucodenix.nixosModules.default
        # FIXME curently depends on unstable	nixarr.nixosModules.default

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.sharedModules = [
            nix-index-database.hmModules.nix-index
            ragenix.homeManagerModules.default
            nix-flatpak.homeManagerModules.nix-flatpak
            #nixvim.homeManagerModules.nixvim
            ghostty.homeModules.default
          ];
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
        }
      ],
      extraModules ? [],
      system ? "x86_64-linux",
      nixpkgs ? inputs.nixpkgs,
    }:
      nixpkgs.lib.nixosSystem {
        system = system;
        modules = baseModules ++ extraModules;
        specialArgs = {
          inherit inputs;
        };
      };
  in {
    formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations = {
      zuse-klappi = mkNixosConfiguration {
        extraModules = [
          ./hosts/zuse-klappi
        ];
      };
      zuse = mkNixosConfiguration {
        extraModules = [
          ./hosts/zuse
        ];
      };
      router = mkNixosConfiguration {
        baseModules = [
          ./common/secrets.nix
          ragenix.nixosModules.default
          nix-topology.nixosModules.default
          impermanence.nixosModules.impermanence
          nixos-sbc.nixosModules.default
          nixos-sbc.nixosModules.boards.bananapi.bpir4
          nix-index-database.nixosModules.nix-index
          ./common/profiles/minimal.nix
          ./common/profiles/perlless.nix
        ];
        extraModules = [
          ./hosts/router
        ];
        system = "aarch64-linux";
      };
      nas = mkNixosConfiguration {
        baseModules = [
          ./common/secrets.nix
          ragenix.nixosModules.default
          nix-topology.nixosModules.default
          nixarr.nixosModules.default
          impermanence.nixosModules.impermanence
          nixos-sbc.nixosModules.default
          nixos-sbc.nixosModules.boards.raspberrypi.rpi4
          inputs.argon40-nix.nixosModules.default
          nix-index-database.nixosModules.nix-index
          ./common/profiles/minimal.nix
          ./common/profiles/perlless.nix
        ];
        extraModules = [
          ./hosts/nas
        ];
        system = "aarch64-linux";
        nixpkgs = inputs.nixpkgs-unstable;
      };
    };
    topology.x86_64-linux = import nix-topology {
      inherit pkgs;
      modules = [
        # Your own file to define global topology. Works in principle like a nixos module but uses different options.
        ./topology.nix
        # Inline module to inform topology of your existing NixOS hosts.
        {nixosConfigurations = self.nixosConfigurations;}
      ];
    };
  };
}
