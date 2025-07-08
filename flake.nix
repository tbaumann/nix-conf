{
  description = "My flake for everything";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    clan-core = {
      url = "git+https://git.clan.lol/clan/clan-core";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    update-systemd-resolved = {
      url = "github:jonathanio/update-systemd-resolved";
      inputs.nixpkgs.follows = "nixpkgs"; # optional
    };
    #stylix.url = "github:danth/stylix/release-24.11";
    stylix.url = "github:danth/stylix/release-25.05";
    #stylix.url = "github:danth/stylix/";
    base16.url = "github:SenchoPens/base16.nix";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      #url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-networkmanager-profiles = {
      url = "github:jmackie/nixos-networkmanager-profiles";
      flake = false;
    };
    terranix.url = "github:terranix/terranix";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
    wpaperd = {
      url = "github:Narice/wpaperd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nvf.url = "github:notashelf/nvf/ff31e0fe25ab21e138efa8d7a3f8628c75a845fd";
    nvf.url = "github:notashelf/nvf/";
    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";

    waybar_weather_display.url = "github:tbaumann/waybar_weather_display";
    waybar_media_display.url = "github:tbaumann/waybar_media_display";
    iio-sway.url = "github:tbaumann/iio-sway";

    nixarr.url = "github:rasmus-kirk/nixarr";
    argon40-nix.url = "github:guusvanmeerveld/argon40-nix";

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

    nix-topology.url = "github:oddlama/nix-topology";
    nix-topology.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    ghostty-shaders = {
      url = "github:hackr-sh/ghostty-shaders";
      flake = false;
    };
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
          inputs.terranix.flakeModule
          ./checks.nix
          ./clan.nix
          ./devshells.nix
          ./formatter.nix
          ./topology.nix
          ./pkgs.nix
        ];
      }
    );
}
