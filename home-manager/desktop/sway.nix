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

  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      terminal = "${pkgs.ghostty}/bin/ghostty";
    };
  };
  programs.i3status-rust.enable = true;
  programs.i3status-rust.bars = {
    default = {
      theme = "ctp-frappe";
      icons = "awesome6";
      blocks = [
        {
          theme_overrides = {
            idle_bg = "#8caaee";
            idle_fg = "#303446";
          };
          block = "focused_window";
          format = {
            full = " $title.str(max_w:15) |";
            short = " $title.str(max_w:10) |";
          };
        }
        {
          block = "keyboard_layout";
          driver = "sway";
          format = " ⌨ $layout ";
          mappings = {
            "English (US)" = "us";
          };
        }
        {
          block = "music";
          format = "$icon {$combo.str(max_w:20,rot_interval:0.5) $play $next |}";
        }
        /*
        {
          block = "notify";
          click = [
            {
              button = "left";
              action = "show";
            }
            {
              button = "right";
              action = "toggle_paused";
            }
          ];
        }
        */
        {
          block = "privacy";
          driver = [
            {
              name = "v4l";
            }
          ];
        }
        {
          block = "sound";
          click = [
            {
              button = "left";
              cmd = "pavucontrol";
            }
          ];
        }

        {
          block = "time";
          format = " $timestamp.datetime(f:'%a %d/%m %R') ";
          interval = 60;
        }
        {
          block = "custom";
          interval = 1200;
          command = "wttrbar --location Marrakech";
          format = "{ $icon|} $text.pango-str()°";
          json = true;
        }
        {
          block = "battery";
          missing_format = "";
        }
        {
          block = "custom";
          format = " ";
          command = "/run/current-system/sw/bin/false";
          interval = "once";
          click = [
            {
              button = "left";
              cmd = "${pkgs.wlogout}/bin/wlogout";
            }
          ];
        }
      ];
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        #command = "${pkgs.swaylock-effects}/bin/swaylock --daemonize";
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
      {
        event = "lock";
        #command = "${pkgs.swaylock-effects}/bin/swaylock --daemonize --grace 0";
        command = "${pkgs.hyprlock}/bin/hyprlock --immediate";
      }
      {
        event = "unlock";
        #command = "pkill -SIGUSR1 swaylock";
        command = "pkill -SIGUSR1 hyprlock";
      }
      {
        event = "after-resume";
        command = "swaymsg \"output * dpms on\"";
      }
    ];
    timeouts = [
      {
        timeout = 1800;
        #command = "${pkgs.swaylock-effects}/bin/swaylock --daemonize";
        command = "${pkgs.hyprlock}/bin/hyprlock";
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

  programs.iio-sway.enable = true;
  programs.hyprlock = {
    enable = true;
    settings = {
      "$font" = "JetBrainsMono Nerd Font";
      grace = 3;
      # TIME
      label = [
        {
          text = ''cmd[update:30000] echo "$(date +"%R")"'';
          font_size = 90;
          font_family = "$font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }

        # DATE
        {
          text = ''cmd[update:43200000] echo "$(date +"%A, %d %B %Y")"'';
          font_size = 25;
          font_family = "$font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];

      # USER AVATAR

      image = [
        {
          path = "~/.face";
          size = 100;

          position = "0, 100";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    wrapperFeatures.base = true;
    wrapperFeatures.gtk = true;
    swaynag.enable = true;
    systemd.xdgAutostart = true;

    config = {
      output = {
        "eDP-1" = {
          scale = "1"; #FIXME
        };
      };
      modifier = "Mod4";
      #terminal = "foot";
      terminal = "${pkgs.ghostty}/bin/ghostty";
      menu = "${pkgs.fuzzel}/bin/fuzzel";
      input = {
        "type:pointer" = {
          natural_scroll = "enabled";
        };
        "type:keyboard" = {
          xkb_layout = "us,ara";
          xkb_options = "compose:ralt,compose:rwin";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };
      bars = [
        {
          id = "top";
          position = "top";
          fonts = {
            names = ["DejaVu Sans Mono" "FontAwesome6"];
            style = "Bold Semi-Condensed";
            size = 11.0;
          };
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
        }
      ];
      colors = let
        # https://github.com/catppuccin/i3/blob/main/themes/catppuccin-mocha
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      in {
        focused = {
          border = "${lavender}";
          childBorder = "${mauve}";
          background = "${red}";
          text = "${crust}";
          indicator = "${rosewater}";
        };
        unfocused = {
          border = "${overlay0}";
          childBorder = "${overlay0}";
          background = "${mauve}";
          text = "${crust}";
          indicator = "${rosewater}";
        };
        focusedInactive = {
          border = "${overlay0}";
          childBorder = "${overlay0}";
          background = "${peach}";
          text = "${crust}";
          indicator = "${rosewater}";
        };
        urgent = {
          border = "${peach}";
          childBorder = "${peach}";
          background = "${red}";
          text = "${crust}";
          indicator = "${overlay0}";
        };
        placeholder = {
          border = "${overlay0}";
          childBorder = "${overlay0}";
          background = "${mauve}";
          text = "${crust}";
          indicator = "${overlay0}";
        };
        background = "${sapphire}";
      };
      keybindings = let
        terminal = config.wayland.windowManager.sway.config.terminal;
        menu = config.wayland.windowManager.sway.config.menu;
        modifier = config.wayland.windowManager.sway.config.modifier;
      in {
        # Default keybindings
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec ${menu}";
        "${modifier}+Shift+d" = "exec ${terminal} -a launcher -e ${pkgs.sway-launcher-desktop}/bin/sway-launcher-desktop";

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

        "${modifier}+t" = "split toggle";

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
        #        "Print" = "~/.config/hypr/scripts/screenshot --area";
        #        "Shift+Print" = "~/.config/hypr/scripts/screenshot --now";
        "Ctrl+Alt+Delete" = "exit";
        "F12" = "exec ${pkgs.wlogout}/bin/wlogout";
        #"${modifier}+Shift+l" = "${pkgs.swaylock-effects}/bin/swaylock --daemonize --grace 0";
        "${modifier}+Shift+l" = "${pkgs.hyprlock}/bin/hyprlock --immediate";
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
        {
          criteria = {
            app_id = "^launcher$";
          };
          command = "floating enable, sticky enable, resize set 30 ppt 60 ppt, border pixel 10";
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
        #        {command = "nwg-panel";}
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
        {command = "blueman-applet";}
      ];
    };
  };
}
