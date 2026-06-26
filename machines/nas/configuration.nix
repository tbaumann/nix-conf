{
  config,
  inputs,
  lib,
  pkgs,
  self,
  ...
}: {
  imports =
    (with inputs; [
      nixos-sbc.nixosModules.default
      nixos-sbc.nixosModules.boards.raspberrypi.rpi4
      hermes-agent.nixosModules.default
      odysseus.nixosModules.default
    ])
    ++ [
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
    (with pkgs; [
      bat
      jq
      gh
      playwright
      nodejs_26
    ])
    ++ (with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      /*
      llm-agents.qmd
      llm-agents.ck
      */
      #      agent-browser
      rtk
      icm
      hermes-hud
    ]);
  services.openssh.enable = true;
  networking.firewall.enable = false;
  services.logind.settings.Login.KillUserProcesses = false;

  services.hermes-agent = {
    enable = true;
    mcpServers = {
      epicure = {
        url = "https://epicure-mcp.kaikaku.ai/mcp";
        enabled = true;
      };
      icm = {
        command = "/run/current-system/sw/bin/icm";
        args = [
          "serve"
          #"--no-embeddings"
        ];
        timeout = 120;
        connect_timeout = 30;
      };
    };
    settings = {
      gateway.platforms.telegram.gateway_restart_notification = false;
      smart_model_routing.enabled = true;
      unauthorized_dm_behavior = "pair";
      worktree = false;
      model = {
        default = "qwen/qwen3.6-plus";
        provider = "nous";
      };
      fallback_model = {
        model = "openrouter/free";
        provider = "openrouter";
      };
      memory.provider = "hermes-icm-memory";
      context.engine = "lcm";
      plugins.hermes-icm-memory.use_embeddings = true;
      memory = {
        memory_enabled = true;
        user_profile_enabled = true;
      };
      web = {
        backend = "firecrawl";
        use_gateway = true;
      };
      browser = {
        backend = "nous";
        engine = "auto";
        auto_local_for_private_urls = true;
        cloud_provider = "browser-use";
        use_gateway = true;
      };
      tts = {
        provider = "omnivoice";
        omnivoice.voice = "female, young adult, british accent, Moroccan Arabic";
        openai = {
          model = "gpt-4o-mini-tts";
          voice = "nova";
        };
        elevenlabs = {
          voice_id = "OfGMGmhShO8iL9jCkXy8";
          model_id = "eleven_multilingual_v2";
        };
        use_gateway = true;
      };
      image_gen = {
        use_gateway = true;
      };
      video_gen = {
        provider = "fal";
        use_gateway = true;
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
    environment.LCM_ENABLE_SLASH_COMMAND = "1";
    addToSystemPackages = true;
    extraDependencyGroups = [
      "messaging"
      "tts-premium"
      "voice"
      "firecrawl"
      "exa"
      "fal"
    ];
    settings.plugins.enabled = [
      "rtk-rewrite"
      "weather"
      "disk-cleanup"
      "image_gen/fal"
      "web/brave_free"
      "hermes-icm-memory"
      "hermes-lcm"
      "omnivoice"
    ];
    # Directory-style plugins: a plugin.yaml lives at the package root and
    # hermes discovers them by symlinking into its plugins directory.
    extraPlugins = [
      (pkgs.fetchFromGitHub {
        name = "plugin-icm-memory";
        owner = "ta3pks";
        repo = "hermes-icm-memory";
        rev = "v0.4.0";
        hash = "sha256-djLy4jBYEYurLoabZzNMKhJzqy6t/OlsWC4V+AZoNGI=";
      })
      (pkgs.fetchFromGitHub {
        name = "plugin-hermes-lcm";
        owner = "stephenschoettler";
        repo = "hermes-lcm";
        rev = "v0.16.1";
        hash = "sha256-Pks7Mf3d90lHEYwNq7dA3BGR9YgZawTav6nHpHgH9nk=";
      })
    ];
    # Entry-point plugins: pip-packaged, register via the
    # `hermes_agent.plugins` entry-point group and are added to PYTHONPATH.
    # (Their plugin.yaml lives inside the installed package, not at the root,
    # so they do NOT belong in extraPlugins.)
    extraPythonPackages = [
      # NOTE: torch MUST be listed explicitly here, even though it already
      # comes in transitively via torchaudio/omnivoice below. Reason: nixpkgs
      # torch is a multi-output derivation (out, dev, lib, cxxdev, dist) and
      # torchaudio depends on torch's *dev* output (headers/linking), which has
      # NO python site-packages. When torch only arrives transitively,
      # requiredPythonModules yields just torch.dev, so hermes's
      # resolve-plugin-pythonpath.py sees no site-packages dir and silently
      # drops torch from PYTHONPATH. Listing torch directly pulls in its
      # default *out* output (which has site-packages), so `import torch` works.
      ((pkgs.python312Packages.torch.override {
        mklDnnSupport = false;
      }).overridePythonAttrs (old: {
        doCheck = false;
        pythonImportsCheck = [ ];
      }))
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
      (pkgs.python312Packages.buildPythonPackage {
        pname = "hermes-omnivoice";
        version = "0.1.0";
        src = pkgs.fetchFromGitHub {
          owner = "ThaungThanHan";
          repo = "hermes-omnivoice";
          rev = "21d2900c392247dc52d706fee956f08dbfc3c5ea";
          hash = "sha256-eDJJmkPsFjEy92XLO/P9Dg/RQD1BGJoG1A7N2i2RmNU=";
        };
        propagatedBuildInputs = [
          pkgs.python312Packages.pyyaml
          ((pkgs.python312Packages.torch.override {
            mklDnnSupport = false;
          }).overridePythonAttrs (old: {
            doCheck = false;
            pythonImportsCheck = [ ];
          }))
          pkgs.python312Packages.soundfile
          (pkgs.python312Packages.torchaudio.overridePythonAttrs (old: {
            doCheck = false;
          }))
          (pkgs.python312Packages.buildPythonPackage {
            pname = "omnivoice";
            version = "0.1.5";
            src = pkgs.fetchFromGitHub {
              owner = "k2-fsa";
              repo = "OmniVoice";
              rev = "0.1.5";
              hash = "sha256-cbtMvtz1N96aa7RmcAJiCaxLT+kFOGlirbeOkgMo+cU=";
            };
            format = "pyproject";
            build-system = [pkgs.python312Packages.hatchling];
            propagatedBuildInputs = with pkgs.python312Packages; [
              numpy
              soundfile
              ((torch.override {
                mklDnnSupport = false;
              }).overridePythonAttrs (old: {
                doCheck = false;
                pythonImportsCheck = [ ];
              }))
              (torchaudio.overridePythonAttrs (old: {
                doCheck = false;
              }))
              transformers
              accelerate
              pydub
              gradio
              tensorboardx
              webdataset
              (librosa.overridePythonAttrs (old: {
                doCheck = false;
              }))
            ];
            doCheck = false;
          })
        ];
        doCheck = false;
        format = "pyproject";
        build-system = [pkgs.python312Packages.setuptools];
      })
      # Built from ./pkgs/python-weather (see common/overlays). Pulls in the
      # full FahrenheitResearch Rust-backed weather stack as dependencies.
      # pkgs.python312Packages.hermes-weather-plugin
    ];
  };
  sops.secrets."hermes-env".owner = "hermes";
  sbc.version = "0.3";
  networking.useNetworkd = lib.mkForce true;
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = "aarch64-linux";
}
