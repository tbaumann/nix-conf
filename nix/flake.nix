{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-coolercontrol.url = "github:codifryed/nixpkgs/coolercontrol-0.17.0";
    wpaperd.url = "github:Narice/wpaperd";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    update-systemd-resolved = {
      url = "github:jonathanio/update-systemd-resolved";
      inputs.nixpkgs.follows = "nixpkgs"; # optional
    };
    stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:tbaumann/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-networkmanager-profiles = {
      url = "github:jmackie/nixos-networkmanager-profiles";
      flake = false;
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # anyrun - a wayland launcher
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    # AstroNvim is an aesthetic and feature-rich neovim config.
    astronvim = {
      url = "github:AstroNvim/AstroNvim/v3.37.8";
      flake = false;
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-23.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };
    # color scheme - catppuccin
    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };
    catppuccin-fcitx5 = {
      url = "github:catppuccin/fcitx5";
      flake = false;
    };
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };
    catppuccin-wezterm = {
      url = "github:catppuccin/wezterm";
      flake = false;
    };
    catppuccin-helix = {
      url = "github:catppuccin/helix";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
    catppuccin-hyprland = {
      url = "github:catppuccin/hyprland";
      flake = false;
    };
    catppuccin-i3 = {
      url = "github:catppuccin/i3";
      flake = false;
    };
    catppuccin-cava = {
      url = "github:catppuccin/cava";
      flake = false;
    };
    catppuccin-k9s = {
      url = "github:catppuccin/k9s";
      flake = false;
    };
    catppuccin-fish = {
      url = "github:catppuccin/fish";
      flake = false;
    };
    catppuccin-foot = {
      url = "github:catppuccin/foot";
      flake = false;
    };
    catppuccin-vsc = {
      url = "github:catppuccin/vscode";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, agenix, nix-flatpak, wpaperd, nixpkgs-coolercontrol, update-systemd-resolved, stylix, base16, nix-index-database, nixvim, ...} @inputs:
  let
    mkNixosConfiguration =
      { baseModules ? [
          ./common/secrets.nix
          agenix.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
          update-systemd-resolved.nixosModules.update-systemd-resolved
          stylix.nixosModules.stylix
          base16.nixosModule
          nix-index-database.nixosModules.nix-index
          nixvim.nixosModules.nixvim

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              nix-flatpak.homeManagerModules.nix-flatpak
              nixvim.homeManagerModules.nixvim
            ];
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
        ]
      , extraModules ? [ ]
      }: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
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
          nixpkgs-coolercontrol.nixosModules.coolercontrol
          ./hosts/zuse-klappi
        ];
      };
      zuse = mkNixosConfiguration {
        extraModules = [
          ./hosts/zuse
        ];
      };
    };
  };
}
