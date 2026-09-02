{
  inputs,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
  imports = [
    inputs.niri-flake.homeModules.niri
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.dms-plugin-registry.nixosModules.default
    inputs.dankcalendar.homeModules.default
    ./settings.nix
    ./binds.nix
    ./rules.nix
  ];

  programs.dank-calendar = {
    enable = true;
    quickshell = with inputs; {
      package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true;

    quickshell = with inputs; {
      package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
    settings = {
      niriLayoutGapsOverride = -2;
      barElevationEnabled = false;
      blurEnabled = true;
      blurWallpaperOnOverview = true;
      terminalsAlwaysDark = true;
      powerMenuActions = [
        "reboot"
        "logout"
        "poweroff"
        "lock"
        "suspend"
        "restart"
        "hibernate"
        "softreboot"
        "switchuser"
      ];
      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [
            "all"
          ];
          showOnLastDisplay = true;
          leftWidgets = [
            "launcherButton"
            "workspaceSwitcher"
            "focusedWindow"
          ];
          centerWidgets = [
            "music"
            "clock"
            "weather"
          ];
          rightWidgets = [
            "systemTray"
            "clipboard"
            "cpuUsage"
            "memUsage"
            "notificationButton"
            "battery"
            "controlCenterButton"
          ];
          spacing = 4;
          innerPadding = 4;
          bottomGap = 0;
          transparency = 1;
          widgetTransparency = 1;
          squareCorners = false;
          noBackground = false;
          gothCornersEnabled = false;
          gothCornerRadiusOverride = false;
          gothCornerRadiusValue = 12;
          borderEnabled = false;
          borderColor = "surfaceText";
          borderOpacity = 1;
          borderThickness = 1;
          fontScale = 1;
          autoHide = false;
          autoHideDelay = 250;
          openOnOverview = false;
          visible = true;
          popupGapsAuto = true;
          popupGapsManual = 4;
        }
      ];
      desktopWidgetInstances = [
        {
          id = "dw_1788345875413_1wtziusii";
          widgetType = "desktopClock";
          name = "Desktop Clock";
          enabled = true;
          config = {
            style = "digital";
            transparency = 0.8;
            colorMode = "primary";
            customColor = "#ffffff";
            showDate = true;
            showAnalogNumbers = false;
            showAnalogSeconds = true;
            displayPreferences = [
              "all"
            ];
          };
        }
        {
          id = "dw_1788345882081_1bngo58vo";
          widgetType = "dankDesktopWeather";
          name = "Dank Desktop Weather";
          enabled = true;
          config = {
            displayPreferences = [
              "all"
            ];
            viewMode = "detailed";
          };
        }
        {
          id = "dw_1788346051047_1lw1810k2";
          widgetType = "dankAudioVisualizer";
          name = "Dank Audio Visualizer";
          enabled = true;
          config = {
            displayPreferences = [
              "all"
            ];
            fadeWhenIdle = false;
          };
        }
      ];
      builtInPluginSettings = {
        dms_settings_search.trigger = "?";
        dms_clipboard_search.trigger = "cb";
        dms_qr_generator.trigger = "qrg";
      };
      clipboardUseOverlayLayer = true;
      showWorkspaceIndex = true;
      workspaceNameIcons = {
        "01comms" = {
          type = "icon";
          value = "forum";
        };
        "02browser" = {
          type = "icon";
          value = "webhook";
        };
        "03term" = {
          type = "icon";
          value = "terminal";
        };
        "09video" = {
          type = "icon";
          value = "movie";
        };
      };
    };
    plugins = {
      dankBatteryAlerts.enable = true;
      aiAssistant.enable = true;
      calculator.enable = true;
      dankBitwarden.enable = true;
      dankDesktopWeather.enable = true;
      dankGifSearch.enable = true;
      dankKDEConnect.enable = true;
      dankPomodoroTimer.enable = true;
      displayManager.enable = true;
      niriScreenshot.enable = true;
      nixMonitor.enable = true;
      wallpaperDiscovery.enable = true;
    };
    niri = {
      enableSpawn = true;
      enableKeybinds = false;
      includes = {

        override = true; # If disabled, DMS settings won't be prioritized over settings defined using niri-flake
        originalFileName = "hm"; # A new name (without extension) for the config file generated by niri-flake.
        filesToInclude = [
          # Files under `$XDG_CONFIG_HOME/niri/dms` to be included into the new config
          "alttab" # Please note that niri will throw an error if any of these files are missing.
          "binds"
          "colors"
          "layout"
          "outputs"
          "wpblur"
        ];
      };
    };
  };

  home.packages = with pkgs; [
    seatd
    xwayland-satellite
    jaq
  ];
}
