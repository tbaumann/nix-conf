{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.niri = with config.lib.stylix.colors; {
    enable = true;
    package = lib.mkForce pkgs.niri-stable;
    settings = {
      environment = {
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
        XDG_SESSION_TYPE = "wayland";
      };
      spawn-at-startup = [
        {command = ["wl-paste" "--watch" "cliphist" "store"];}
        {command = ["wl-paste" "--type text" "--watch" "cliphist" "store"];}

        #{command = "nm-applet";}
        #{command = "wl-clip-persist --clipboard regular";}
        # {command = "syncthingtray --wait";}
        {command = ["solaar" "-w" "hide"];}
        {command = ["polychromatic-tray-applet"];}
        {command = ["coolercontrol"];}
        {sh = "NIXOS_OZONE_WL='' joplin-desktop";}
        {command = ["firefox"];}
        {command = ["chromium"];}
        {command = ["thunderbird"];}
        {command = ["rambox" "--enable-features=WaylandWindowDecorations" "--ozone-platform-hint=auto" "--enable-webrtc-pipewire-capturer"];}
        {command = ["openrgb" "--startminimized"];}
        {command = ["linphone" "--iconified"];}
        {command = ["blueman-applet"];}
        {command = ["${pkgs.kdePackages.kdeconnect-kde}/bin/kdeconnect-indicator"];}
      ];
      input = {
        keyboard.xkb = {
          layout = "us";
          options = "compose:ralt,compose:rwin";
        };

        mouse = {
          natural-scroll = true;
        };
        touchpad = {
          click-method = "button-areas";
          dwt = true;
          dwtp = true;
          natural-scroll = true;
          scroll-method = "two-finger";
          tap = true;
          tap-button-map = "left-right-middle";
          middle-emulation = true;
          accel-profile = "adaptive";
        };
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "90%";
        };
        warp-mouse-to-focus.enable = true;
        workspace-auto-back-and-forth = true;
      };
      screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";
      outputs = {
        "eDP-1" = {
          scale = 1.0;
          position = {
            x = 0;
            y = 0;
          };
        };
        "HDMI-A-1" = {
          scale = 2.0;
        };
      };

      overview = {
        workspace-shadow.enable = false;
        backdrop-color = "transparent";
      };
      gestures = {hot-corners.enable = true;};
      cursor = {
        size = 20;
      };
      layout = {
        focus-ring.enable = false;
        border = {
          enable = true;
          width = 2;
          #active.color = "#${base0B}";
          #inactive.color = "#${base0F}";
        };
        shadow = {
          enable = false;
        };
        preset-column-widths = [
          {proportion = 0.25;}
          {proportion = 0.5;}
          {proportion = 0.75;}
          {proportion = 1.0;}
        ];
        default-column-width = {
          proportion = 0.5;
        };

        gaps = 6;
        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };

        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 20.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
        };
      };
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
      workspaces = {
        "01comms" = {
          #name = "󰇮";
        };
        "02browser" = {
          #name = "󰈹";
        };
        "03term" = {
          #name = "";
        };
        "09video" = {
          #name = "";
        };
      };
      window-rules = [
        {
          matches = [
            {
              app-id = "firefox";
              at-startup = true;
            }
          ];
          open-on-workspace = "02browser";
          open-maximized = true;
        }
        {
          matches = [
            {
              app-id = "chromium";
              at-startup = true;
            }
          ];
          open-on-workspace = "09video";
          open-maximized = true;
        }
        {
          matches = [
            {
              app-id = "thunderbird";
              at-startup = true;
            }
            #{app-id = "rambox";}
          ];

          open-on-workspace = "09video";
          default-column-width.proportion = 0.5;
        }
      ];
    };
  };
}
