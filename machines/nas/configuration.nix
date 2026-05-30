{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  goclaw = inputs.goclaw.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (
    attrs: {doCheck = false;}
  );
in {
  imports = with inputs; [
    nixos-sbc.nixosModules.default
    nixos-sbc.nixosModules.boards.raspberrypi.rpi4
    onemcp.nixosModules.default
    hermes-agent.nixosModules.default
    ../../modules/shared.nix
    ../../common/core.nix
    ../../common/tailscale.nix
  ];
  system.etc.overlay.enable = true;
  #boot.initrd.systemd.enable = true;
  system.nixos-init.enable = lib.mkForce false;
  systemd.oomd.enable = true;
  documentation.enable = false;
  documentation.man.enable = false;
  environment.systemPackages = with pkgs;
  with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    bat
    jq
    playwright
    /*
    llm-agents.qmd
    llm-agents.ck
    */
    agent-browser
    rtk
  ];
  #    moltis.packages.${pkgs.stdenv.hostPlatform.system}.default
  services.openssh.enable = true;
  networking.firewall.enable = false;
  services.logind.settings.Login.KillUserProcesses = false;
  services.hermes-agent = {
    enable = true;
    settings = {
      smart_model_routing.enabled = true;
      model = {
        default = "openai/gpt-5.4-nano";
        provider = "nous";
      };
      fallback_model = {
        model = "openrouter/free";
        provider = "openrouter";
      };
      plugins.enabled = [
        "hermes-lcm"
        "rtk-rewrite"
        "disk-cleanup"
        "image_gen/fal"
        "web/brave_free"
      ];
      memory = {
        memory_enabled = true;
        user_profile_enabled = true;
      };
      web = {
        backend = "firecrawl";
        use_gateway = true;
        provider = "nous";
      };
      browser = {
        backend = "nous";
        engine = "auto";
        auto_local_for_private_urls = true;
        cloud_provider = "browser-use";
        use_gateway = true;
      };
      tts = {
        provider = "openai";
        openai = {
          model = "gpt-4o-mini-tts";
          voice = "alloy";
        };
        use_gateway = true;
        #provider = "nous";
      };
      image_gen = {
        use_gateway = true;
        provider = "nous";
      };
      voice = {
        record_key = "ctrl+b"; # Push-to-talk key inside the CLI
        auto_tts = false; # Enable spoken replies automatically when /voice on
        beep_enabled = true;
      };

      display = {
        tool_progress = "all"; # off | new | all | verbose
        interim_assistant_messages = true; # Gateway: send natural mid-turn assistant updates as separate messages
        compact = false; # Compact output mode (less whitespace)
        bell_on_complete = true; # Play terminal bell when agent finishes (great for long tasks)
        show_reasoning = true; # Show model reasoning/thinking above each response (toggle with /reasoning show|hide)
        show_cost = true; # Show estimated $ cost in the CLI status bar
        file_mutation_verifier = true; # Append an advisory footer when write_file/patch calls failed this turn
      };
    };
    environmentFiles = [config.sops.secrets."hermes-env".path];
    addToSystemPackages = true;
    extraDependencyGroups = ["messaging" "tts-premium" "voice" "firecrawl" "exa"];
    extraPlugins = [
      /*
      (pkgs.python312Packages.buildPythonPackage {
        pname = "plugin-rtk-hermes";
        version = "1.2.3";
        src = pkgs.fetchFromGitHub {
          owner = "ogallotti";
          repo = "rtk-hermes";
          rev = "v1.2.3";
          hash = "sha256-7YRW6PODrCapfYLFn3DvgHAEME//RGC48GQt+s9ot0s=";
        };
        format = "pyproject";
        build-system = [pkgs.python312Packages.setuptools];
      })
      (
        pkgs.fetchFromGitHub {
          owner = "stephenschoettler";
          repo = "hermes-lcm";
          rev = "v0.14.0";
          hash = "sha256-3pB/tQ6DSdjaPDTFTulIXkiPeRap0yLBq22LLTn2rs8=";
        }
      )
      (
        pkgs.fetchFromGitHub {
          owner = "FahrenheitResearch";
          repo = "hermes-weather-plugin";
          rev = "d474493ef4ffeefabad9dbf0188f72bce3b47b67";
          hash = "";
        }
      )
      */
    ];
  };
  sops.secrets."hermes-env".owner = "hermes";
  /*
  services.onemcp-agent = {
    enable = true;
    port = 3000; # Default port
    args = ["--lazy-mode"];

    # Declarative MCP Server Configuration
    servers = {
      # Use Nix packages directly (Stdio transport)
      # This handles absolute paths automatically
      "nixos-mcp" = {
        transport = "stdio";
        command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
        tags = ["nixos" "system"];
      };
      "google" = {
        transport = "http";
        url = "https://workspace-developer.goog/mcp";
        tags = ["remote"];
      };
    };
  };
  */
  sbc.version = "0.3";
  networking.useNetworkd = lib.mkForce true;
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = "aarch64-linux";
}
