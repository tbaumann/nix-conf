{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/shared.nix

    ../../common/core.nix
    ../../common/core-desktop.nix
    ../../common/core-pc.nix
    ../../common/work/syseleven
    ./hardware-configuration.nix
    inputs.win98se-plymouth.nixosModules.default
  ];
  topology.self = {
    hardware.info = "24 core Threadripper workstation";
    interfaces.eno1 = {
      network = "home"; # Use the network we define below
    };
  };
  boot.kernelPackages = pkgs.linuxPackages.extend (
    _self: super: {
      liquidtux = super.liquidtux.overrideAttrs (oldAttrs: {
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.python3Minimal ];
        # nixpkgs' aggregateModules now wants a per-module .ko.cer next to
        # every module it finds in modules.dep, and it builds that path from
        # modules.dep. liquidtux installs its modules by hand, so kbuild never
        # signs them and no certificate is produced (NixOS/nixpkgs#575192).
        # Sign them the same deterministic way the in-tree build does.
        installPhase = ''
          runHook preInstall
          cd drivers/hwmon
          for m in nzxt-grid3.ko nzxt-kraken2.ko nzxt-kraken3.ko nzxt-smart2.ko; do
            ${pkgs.buildPackages.kmodigest}/bin/kmodigest "$m"
          done
          install nzxt-grid3.ko nzxt-kraken2.ko nzxt-kraken3.ko nzxt-smart2.ko \
                  nzxt-grid3.ko.cer nzxt-kraken2.ko.cer nzxt-kraken3.ko.cer nzxt-smart2.ko.cer \
            -Dm444 -t $out/lib/modules/${super.kernel.modDirVersion}/kernel/drivers/hwmon
          runHook postInstall
        '';
      });
    }
  );
  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    extraModulePackages = with config.boot.kernelPackages; [ liquidtux ];

    extraModprobeConfig = "options kvm_amd nested=1";
  };
  environment.systemPackages = with pkgs; [
    liquidctl
    python3Minimal
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.hermes-desktop
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.hermes-agent
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.hermes-hud
  ];
  networking = {
    useNetworkd = lib.mkForce true;
    wireguard.useNetworkd = true;
    hostName = "zuse";
    nat = {
      enable = true;
      internalInterfaces = [ "microbr" ];
      externalInterface = "enp69s0";
    };
  };
  systemd.network = {
    netdevs."20-microbr".netdevConfig = {
      Kind = "bridge";
      Name = "microbr";
    };

    networks = {
      "20-microbr" = {
        matchConfig.Name = "microbr";
        addresses = [ { Address = "192.168.83.1/24"; } ];
        networkConfig = {
          ConfigureWithoutCarrier = true;
        };
      };

      "21-microvm-tap" = {
        matchConfig.Name = "microvm*";
        networkConfig.Bridge = "microbr";
      };
    };
  };
  services.esphome.enable = false;
  services.esphome.allowedDevices = [
    "char-ttyS"
    "char-ttyUSB"
    "char-ttyACM"
  ];
  services.ollama = {
    enable = true;
    #package = pkgs.ollama-vulkan;
    loadModels = [
      "gemma4:12b"
      "hf.co/HauhauCS/Gemma-4-E4B-Uncensored-HauhauCS-Aggressive:Q6_K_P"
      "hhao/qwen2.5-coder-tools:14b"
      "gpt-oss:20b"
    ];
  };

  services.llama-cpp = {
    enable = false;
    package = pkgs.llama-cpp-vulkan;
  };
  # services.open-webui.enable = true;
  location = {
    provider = "manual";
    longitude = "51.028791";
    latitude = "8.851719";
  };

  services = {
    btrfs.autoScrub.enable = true;
    hardware.openrgb = {
      enable = true;
      motherboard = "amd";
    };
    pcscd = {
      enable = true;
      plugins = [
        pkgs.ccid
        pkgs.pcsc-cyberjack
      ];
    };
  };
  programs.coolercontrol.enable = true;
  services.udev.packages = with pkgs; [ platformio-core.udev ];
  services.udev.extraRules = ''
    # REINER SCT cyberJack RFID standard (USB ID 0c4b:0500)
    # Set ID_SMARTCARD_READER for systemd smartcard.target
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0c4b", ATTRS{idProduct}=="0500", ENV{ID_SMARTCARD_READER}="1"
    # Grant pcscd group access to the device
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0c4b", ATTRS{idProduct}=="0500", GROUP="pcscd", MODE="0664"
  '';
}
