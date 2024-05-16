{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
  ];
  #Global theming off
  stylix.targets.sway.enable = false;
  #Theme file
  home.file.".config/sway/themes/".source = "${inputs.catppuccin-i3}/themes";

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock --daemonize";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock --daemonize --grace 0";
      }
      {
        event = "unlock";
        command = "pkill -SIGUSR1 swaylock";
      }
      {
        event = "after-resume";
        command = "swaymsg \"output * dpms on\"";
      }
    ];
    timeouts = [
      {
        timeout = 1800;
        command = "${pkgs.swaylock-effects}/bin/swaylock --daemonize";
      }
      {
        timeout = 2000;
        command = "swaymsg \"output * dpms off\"";
        resumeCommand = "swaymsg \"output * dpms on\"";
      }
    ];
  };
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      "screenshots" = true;
      "clock" = true;
      "indicator" = true;
      "effect-blur" = "7x5";
      "fade-in" = "0.2";
      "grace" = 5;
      "indicator-radius" = "100";
    };
  };
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    wrapperFeatures.base = true;
    wrapperFeatures.gtk = true;
    swaynag.enable = true;
    #systemd.xdgAutostart = true;
    extraConfigEarly = ''
      include themes/catppuccin-mocha
    '';

    config = {
      output = {
        "eDP-1" = {
          scale = "1"; #FIXME
        };
      };
      modifier = "Mod4";
      terminal = "foot";
      menu = "anyrun";
      input = {
        "type:pointer" = {
          natural_scroll = "enabled";
        };
        "type:keyboard" = {
          xkb_options = "compose:ralt,compose:rwin";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };
      bars = [];

      /*
      colors.focused = {
        border = "$lavender";
        childBorder = "$mauve";
        background = "$red";
        text = "$crust";
        indicator = "$rosewater";
      };
      colors.unfocused = {
        border = "$overlay0";
        childBorder = "$overlay0";
        background = "$mauve";
        text = "$crust";
        indicator = "$rosewater";
      };
      colors.focusedInactive = {
        border = "$overlay0";
        childBorder = "$overlay0";
        background = "$peach";
        text = "$crust";
        indicator = "$rosewater";
      };
      colors.urgent = {
        border = "$peach";
        childBorder = "$peach";
        background = "$red";
        text = "$crust";
        indicator = "$overlay0";
      };
      colors.placeholder = {
        border = "$overlay0";
        childBorder = "$overlay0";
        background = "$mauve";
        text = "$crust";
        indicator = "$overlay0";
      };
      colors.background = "$sapphire";
      */
      keybindings = let
        terminal = config.wayland.windowManager.sway.config.terminal;
        menu = config.wayland.windowManager.sway.config.menu;
        modifier = config.wayland.windowManager.sway.config.modifier;
      in {
        # Default keybindings
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec ${menu}";

        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+a" = "focus parent";

        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";

        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";

        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

        "${modifier}+r" = "mode resize";

        #Multimedia Keys
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        "XF86Search" = "exec ${menu}";

        # Tilman Custom
        "Mod4+c" = "kill";
        "Mod4+j" = "workspace prev";
        "Mod4+l" = "workspace next";
        "Print" = "~/.config/hypr/scripts/screenshot --area";
        "Shift+Print" = "~/.config/hypr/scripts/screenshot --now";
        "Ctrl+Alt+Delete" = "exit";
        "F12" = "exec ~/.config/hypr/scripts/wlogout";
        "${modifier}+Shift+l" = "${pkgs.swaylock-effects}/bin/swaylock --daemonize --grace 0";
      };
      window.commands = [
        {
          criteria = {
            title = "^Syncthing Tray( \(.*\))?$";
          };
          command = "floating enable, border none, resize set 450 400, move position pointer";
        }
        {
          criteria = {
            class = "zoom";
          };
          command = "floating enable";
        }
        {
          criteria = {
            title = "Meeting(.*)?";
            class = "Microsoft Teams(.*)?";
          };
          command = "floating enable inhibit_idle";
        }
        {
          criteria = {
            title = "Picture-in-Picture";
            app_id = "firefox";
          };
          command = "floating enable";
        }
        #Pushbullet – Mozilla Firefox
        {
          criteria = {
            title = "Pushbullet – Mozilla Firefox";
            app_id = "firefox";
          };
          command = "floating enable";
        }
        #About Mozilla Firefox
        {
          criteria = {
            title = "About Mozilla Firefox";
            app_id = "firefox";
          };
          command = "floating enable";
        }
        #Firefox — Sharing Indicator
        {
          criteria = {
            title = "Firefox — Sharing Indicator";
            app_id = "firefox";
          };
          command = "floating enable";
        }
        # Baby monitor
        {
          criteria = {
            title = "baby - (.*)";
            class = "vlc";
          };
          command = "floating enable";
        }
        {
          criteria = {
            title = "baby";
            app_id = "mpv";
          };
          command = "floating enable";
        }
        # Huddle
        {
          criteria = {
            title = "^Huddle (.*)?";
            app_id = "rambox";
          };
          command = "floating enable inhibit_idle";
        }
        # Linphone
        {
          criteria = {
            app_id = "linphone.";
          };
          command = "floating enable";
        }
      ];
      assigns = {
        "1" = [
          {class = "rambox";}
          {app_id = "thunderbird";}
        ];
        "2" = [{app_id = "firefox";}];
        "8" = [{app_id = "chromium-browser";}];
        "9" = [{title = "CoolerControl";}];
      };
      startup = [
        {command = "nwg-panel";}
        {command = "nm-applet";}
        {command = "solaar -w hide";}
        {command = "polychromatic-tray-applet";}
        {command = "coolercontrol";}
        {command = "joplin-desktop";}
        {command = "wl-clip-persist --clipboard regular";}
        {command = "wpaperd";}
        {command = "firefox";}
        {command = "chromium";}
        {command = "rambox";}
        #{command = "rambox --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --enable-webrtc-pipewire-capturer";}
        {command = "sway-audio-idle-inhibit";}
        {command = "thunderbird";}
        {command = "syncthingtray --wait";}
        {command = "openrgb --startminimized";}
        {command = "linphone --iconified";}
      ];
    };
  };
}
