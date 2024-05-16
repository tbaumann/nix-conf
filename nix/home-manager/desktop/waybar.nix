{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
  ];
  stylix.targets.waybar.enable = false;

  programs.waybar.enable = true;
  programs.waybar.settings = [
    {
      layer = "top";

      position = "top";

      # If height property would be not present, it'd be calculated dynamically
      height = 30;

      "modules-left" = [
        "sway/workspaces"
        "sway/mode"
      ];
      "modules-center" = [
        "sway/window"
      ];
      "modules-right" = [
        "network"
        "memory"
        "cpu"
        "temperature"
        "mpris"
        "battery"
        "idle_inhibitor"
        "tray"
        "clock#date"
        "wireplumber"
        "clock#time"
      ];

      # -------------------------------------------------------------------------
      # Modules
      # -------------------------------------------------------------------------

      "battery" = {
        "interval" = 10;
        "states" = {
          "warning" = 30;
          "critical" = 15;
        };
        # Connected to AC
        "format" = "  {icon}  {capacity}%"; # Icon: bolt
        # Not connected to AC
        "format-discharging" = "{icon}  {capacity}%";
        "format-icons" = [
          "" # Icon: battery-full
          "" # Icon: battery-three-quarters
          "" # Icon: battery-half
          "" # Icon: battery-quarter
          "" # Icon: battery-empty
        ];
        "tooltip" = true;
      };

      "clock#time" = {
        "interval" = 1;
        "format" = "{:%H:%M:%S}";
        "tooltip" = false;
      };

      "clock#date" = {
        "interval" = 10;
        "format" = "  {:%e %b %Y}"; # Icon: calendar-alt
        "tooltip-format" = "{:%e %B %Y}";
      };

      "cpu" = {
        "interval" = 5;
        "format" = "  {usage}% ({load})"; # Icon: microchip
        "states" = {
          "warning" = 70;
          "critical" = 90;
        };
      };

      "custom/keyboard-layout" = {
        "exec" = "swaymsg -t get_inputs | grep -m1 'xkb_active_layout_name' | cut -d '\"' -f4";
        # Interval set only as a fallback, as the value is updated by signal
        "interval" = 30;
        "format" = "  {}"; # Icon: keyboard
        # Signal sent by Sway key binding (~/.config/sway/key-bindings)
        "signal" = 1; # SIGHUP
        "tooltip" = false;
      };
      "idle_inhibitor" = {
        "format" = "{icon}";
        "format-icons" = {
          "activated" = "";
          "deactivated" = "";
        };
      };
      "mpris" = {
        "format" = "DEFAULT: {player_icon} {dynamic}";
        "format-paused" = "DEFAULT: {status_icon} <i>{dynamic}</i>";
        "format-len" = 10;
        "player-icons" = {
          "default" = "▶";
          "mpv" = "🎵";
        };
        "status-icons" = {
          "paused" = "⏸";
        };
        # "ignored-players" = ["firefox"]
      };

      "memory" = {
        "interval" = 5;
        "format" = "  {}%"; # Icon: memory
        "states" = {
          "warning" = 70;
          "critical" = 90;
        };
      };

      "network" = {
        "interval" = 5;
        "format-wifi" = "  {essid} ({signalStrength}%)"; # Icon: wifi
        "format-ethernet" = "  {ifname}: {ipaddr}/{cidr}"; # Icon: ethernet
        "format-disconnected" = "⚠  Disconnected";
        "tooltip-format" = "{ifname}: {ipaddr}";
      };

      "sway/mode" = {
        "format" = "<span style=\"italic\">  {}</span>"; # Icon: expand-arrows-alt
        "tooltip" = false;
      };

      "sway/window" = {
        "format" = "{}";
        "max-length" = 120;
      };

      "sway/workspaces" = {
        "all-outputs" = false;
        "disable-scroll" = true;
        "format" = "{icon} {name}";
        "format-icons" = {
          "1:www" = "龜"; # Icon: firefox-browser
          "2:mail" = ""; # Icon: mail
          "3:editor" = ""; # Icon: code
          "4:terminals" = ""; # Icon: terminal
          "5:portal" = ""; # Icon: terminal
          "urgent" = "";
          "focused" = "";
          "default" = "";
        };
      };
      wireplumber = {
        format = "{volume}%";
        format-muted = "";
        on-click-right = "${pkgs.helvum}/bin/helvum";
        on-click = "${pkgs.pwvucontrol}/bin/pwvucontrol";
        max-volume = 150;
      };

      #"pulseaudio" = {
      #    #"scroll-step" = 1;
      #    "format" = "{icon}  {volume}%";
      #    "format-bluetooth" = "{icon}  {volume}%";
      #    "format-muted" = "";
      #    "format-icons" = {
      #        "headphones" = "";
      #        "handsfree" = "";
      #        "headset" = "";
      #        "phone" = "";
      #        "portable" = "";
      #        "car" = "";
      #        "default" = ["", ""]
      #    };
      #    "on-click" = "pavucontrol"
      #};

      "temperature" = {
        "critical-threshold" = 80;
        "interval" = 5;
        "format" = "{icon}  {temperatureC}°C";
        "format-icons" = [
          "" # Icon: temperature-empty
          "" # Icon: temperature-quarter
          "" # Icon: temperature-half
          "" # Icon: temperature-three-quarters
          "" # Icon: temperature-full
        ];
        "tooltip" = true;
      };

      "tray" = {
        "icon-size" = 21;
        "spacing" = 10;
      };
    }
  ];
  programs.waybar.style = ''
    * {
        border: none;
        border-radius: 0;
        font-family: Roboto,'Font Awesome 5', 'SFNS Display',  Helvetica, Arial, sans-serif;
        font-size: 13px;
        min-height: 0;
    }

    window#waybar {
        background: rgba(43, 48, 59, 0.5);
        border-bottom: 3px solid rgba(100, 114, 125, 0.5);
        color: #ffffff;
    }

    window#waybar.hidden {
        opacity: 0.0;
    }
    /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
    #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: #ffffff;
        border-bottom: 3px solid transparent;
    }

    #workspaces button.focused {
        background: #64727D;
        border-bottom: 3px solid #ffffff;
    }

    #workspaces button.urgent {
        background-color: #eb4d4b;
    }

    #mode {
        background: #64727D;
        border-bottom: 3px solid #ffffff;
    }

    #clock, #battery, #cpu, #memory, #temperature, #backlight, #network, #pulseaudio, #custom-media, #tray, #mode, #idle_inhibitor {
        padding: 0 10px;
        margin: 0 5px;
    }

    #clock {
        background-color: #64727D;
    }

    #battery {
        background-color: #ffffff;
        color: #000000;
    }

    #battery.charging {
        color: #ffffff;
        background-color: #26A65B;
    }

    @keyframes blink {
        to {
            background-color: #ffffff;
            color: #000000;
        }
    }

    #battery.critical:not(.charging) {
        background: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    #cpu {
        background: #2ecc71;
        color: #000000;
    }

    #memory {
        background: #9b59b6;
    }

    #backlight {
        background: #90b1b1;
    }

    #network {
        background: #2980b9;
    }

    #network.disconnected {
        background: #f53c3c;
    }

    #pulseaudio {
        background: #f1c40f;
        color: #000000;
    }

    #pulseaudio.muted {
        background: #90b1b1;
        color: #2a5c45;
    }

    #custom-media {
        background: #66cc99;
        color: #2a5c45;
    }

    .custom-spotify {
        background: #66cc99;
    }

    .custom-vlc {
        background: #ffa000;
    }

    #temperature {
        background: #f0932b;
    }

    #temperature.critical {
        background: #eb4d4b;
    }

    #tray {
        background-color: #2980b9;
    }

    #idle_inhibitor {
        background-color: #2d3436;
    }

    #idle_inhibitor.activated {
        background-color: #ecf0f1;
        color: #2d3436;
    }
  '';
}
