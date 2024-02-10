{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-coolercontrol.url = "github:codifryed/nixpkgs/coolercontrol-0.17.0";
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
    wpaperd = {
      url = "github:Narice/wpaperd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-23.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # color scheme - catppuccin
    catppuccin-hyprland = {
      url = "github:catppuccin/hyprland";
      flake = false;
    };
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
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
    nix-flatpak,
    wpaperd,
    nixpkgs-coolercontrol,
    update-systemd-resolved,
    stylix,
    base16,
    nix-index-database,
    nixvim,
    nixos-hardware,
    auto-cpufreq,
    ...
  } @ inputs: let
    mkNixosConfiguration = {
      baseModules ? [
        ./common/secrets.nix
        agenix.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
        update-systemd-resolved.nixosModules.update-systemd-resolved
        stylix.nixosModules.stylix
        base16.nixosModule
        nix-index-database.nixosModules.nix-index
        nixvim.nixosModules.nixvim
        auto-cpufreq.nixosModules.default

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            nix-index-database.hmModules.nix-index
            agenix.homeManagerModules.default
            nix-flatpak.homeManagerModules.nix-flatpak
            nixvim.homeManagerModules.nixvim
          ];
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
        }
      ],
      extraModules ? [],
      system ? "x86_64-linux",
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
      nas = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          "${nixos-hardware}/raspberry-pi/4"
          ./hosts/nas
        ];
      };
      rpi2 = nixpkgs.lib.nixosSystem {
        modules = [
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
          "${nixos-hardware}/raspberry-pi/4"
          {
            hardware = {
              #              raspberry-pi."4".apply-overlays-dtmerge.enable = true;
              deviceTree = {
                enable = true;
              };
            };
            # hardware.raspberry-pi."4".fkms-3d.enable = true;
            #            services.hardware.argonone.enable = true;
            boot.loader.raspberryPi.version = 4;
            #boot.kernelPackages = [nixpkgs.pkgs.linuxKernel.kernels.linux_rpi4];
            hardware.raspberry-pi."4".fkms-3d.enable = true;
            boot.loader.grub.enable = false;
            boot.loader.generic-extlinux-compatible.enable = true;
            console.enable = false;
            nixpkgs.config.allowUnsupportedSystem = true;
            nixpkgs.hostPlatform.system = "aarch64-linux";
            nixpkgs.buildPlatform.system = "x86_64-linux"; #If you build on x86 other wise changes this.
            # ... extra configs as above
          }
        ];
      };
    };
  };
}
