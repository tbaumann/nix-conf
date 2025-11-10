{
  inputs,
  pkgs,
  config,
  ...
}: {
  stylix = {
    targets = {
      waybar = {
        enable = true;
        enableLeftBackColors = true;
        enableCenterBackColors = true;
        enableRightBackColors = true;
      };
    };
  };

  programs.waybar.enable = true;
  programs.waybar.settings = {
    top = {
      layer = "top";
      name = "top";

      position = "top";

      # If height property would be not present, it'd be calculated dynamically
      height = 30;
      spacing = 0;
      reload_style_on_change = true;
      margin-left = 5;
      margin-right = 5;

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
        "sway/language"
        "idle_inhibitor"
        "wireplumber"
        "tray"
        "clock#time"
        "clock#date"
        "custom/weather"
        "custom/wlogout"
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
        "dynamic-len" = 30;
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
        "sort-by-number" = true;
        "all-outputs" = false;
        "disable-scroll" = true;
        "format" = "{icon} {name}";
        "format-icons" = {
          "1" = ""; # Icon: mail
          "2" = "󰈹"; # Icon: firefox-browser
          "3" = ""; # Icon: code
          "4" = ""; # Icon: terminal
          "5" = ""; # Icon: terminal
          "urgent" = "";
          #          "focused" = "";
          "default" = "";
        };
        "persistent-workspaces" = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
          "6" = [];
          "7" = [];
          "8" = [];
        };
      };
      wireplumber = {
        format = "{volume}% {icon}";
        format-muted = "";
        "format-icons" = ["" "" ""];
        on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        on-click-right = "${pkgs.pwvucontrol}/bin/pwvucontrol";
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
      "custom/weather" = {
        "format" = "{}°";
        "tooltip" = true;
        "interval" = 3600;
        "exec" = "${pkgs.wttrbar}/bin/wttrbar --location Marrakech";
        "return-type" = "json";
      };
      "sway/language" = {
        "on-click" = "swaymsg input type:keyboard xkb_switch_layout next";
      };
      "custom/wlogout" = {
        "on-click" = "${pkgs.wlogout}/bin/wlogout";
        "format" = "  {} ";
        "exec" = "echo ; echo   logout";
        "interval" = 86400;
        "tooltip" = true;
      };
    };
  };
  programs.waybar.style = ''
    * {
        border: none;
        border-radius: 0;
        font-family: Roboto,'Font Awesome 5', 'SFNS Display',  Helvetica, Arial, sans-serif;
        font-size: 13px;
        min-height: 0;
        background-color: black;
        color: #ffffff;
    }

    window#waybar {
        border-bottom: 3px ;
        color: #ffffff;
    }

    window#waybar.hidden {
        opacity: 0.0;
    }

    #mode {
        background-color: #64727D;
    }
    #temperature #language #wireplumber {
        color: #ffffff;
    }
    #custom-wlogout {
        color: red;
    }
  '';
}
