{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    ../../modules/shared.nix

    ../../common/core.nix
    ../../common/core-desktop.nix
    ../../common/core-pc.nix
    ./hardware-configuration.nix
    inputs.odysseus.nixosModules.default
  ];
  topology.self = {
    hardware.info = "24 core Threadripper workstation";
    interfaces.eno1 = {
      network = "home"; # Use the network we define below
    };
  };
  boot.kernelPackages = pkgs.linuxPackages.extend (
    self: super: {
      liquidtux = super.liquidtux.overrideAttrs (oldAttrs: {
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [pkgs.python3Minimal];
      });
    }
  );
  boot = {
    binfmt.emulatedSystems = ["aarch64-linux"];
    extraModulePackages = with config.boot.kernelPackages; [liquidtux];

    extraModprobeConfig = "options kvm_amd nested=1";
  };
  environment.systemPackages = with pkgs; [
    liquidctl
    esphome
    python3Minimal
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.hermes-desktop
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.hermes-agent
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.hermes-hud
  ];
  networking = {
    useNetworkd = lib.mkForce true;
    hostName = "zuse";
    nat = {
      enable = true;
      internalInterfaces = ["microbr"];
      externalInterface = "enp69s0";
    };
  };
  services.odysseus = {
    enable = true;
    environmentFile = config.sops.secrets."odysseus-env".path;
    llamaCpp = {
      enable = true;
      package = pkgs.llama-cpp-vulkan;
    };
    extraEnvironmentVariables = {
      AUTH_ENABLED = "true";
      ODYSSEUS_ADMIN_USER = "admin";
      #LOCALHOST_BYPASS = "true";
      APP_BIND = "0.0.0.0";
    };
  };
  sops.secrets."odysseus-env".owner = "odysseus";
  networking.enableIPv6 = false; ## Fuck you Telekom
  systemd.network = {
    netdevs."20-microbr".netdevConfig = {
      Kind = "bridge";
      Name = "microbr";
    };

    networks = {
      "20-microbr" = {
        matchConfig.Name = "microbr";
        addresses = [{Address = "192.168.83.1/24";}];
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
  services.esphome.enable = true;
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
  services.udev.extraRules = ''
    # REINER SCT cyberJack RFID standard (USB ID 0c4b:0500)
    # Set ID_SMARTCARD_READER for systemd smartcard.target
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0c4b", ATTRS{idProduct}=="0500", ENV{ID_SMARTCARD_READER}="1"
    # Grant pcscd group access to the device
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0c4b", ATTRS{idProduct}=="0500", GROUP="pcscd", MODE="0664"
  '';
}
