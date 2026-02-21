{ ... }:
{
  home-manager.users.cabero = {
    programs.waybar = {
      enable = true;
      style = builtins.readFile ./style.css;
      settings = {
        main = {
          layer = "top";
          height = 32;
          margin-top = 4;
          margin-left = 4;
          margin-right = 4;
          spacing = 4;
          modules-left = [
            "network"
            "niri/language"
            "idle_inhibitor"
            "privacy"
            "pulseaudio"
            "wlr/taskbar"
            "niri/window"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "keyboard-state"
            "tray"
            "cpu"
            "memory"
            "temperature"
          ];

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
            timeout = 60 * 2;
          };

          privacy = {
            icon-size = 16;
          };

          "niri/language" = {
            format = "{short}";
          };

          "niri/window" = {
            icon = true;
            icon-size = 16;
            separate-outputs = true;
            expand = true;
          };

          "wlr/taskbar" = {
            all-outputs = false;
            format = "{icon}";
            tooltip-format = "{title} | {name}";
            on-click = "activate";
            on-click-middle = "close";
          };

          keyboard-state = {
            capslock = true;
            format = "{icon}";
            format-icons = {
              locked = "CAPS";
              unlocked = "";
            };
          };
          tray = {
            icon-size = 21;
            spacing = 10;
            show-passive-items = true;
            expand = true;
          };
          clock = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format = "{:%e %B %H:%M}";
            on-click = "google-chrome-stable --app-id=kjbdgfilnfhdoflbpgamdcdgpehopbep";
          };
          cpu = {
            format = "{usage}% ";
            tooltip = false;
          };
          memory = {
            format = "{}% ";
          };
          temperature = {
            thermal-zone = 2;
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = [
              ""
              ""
              ""
            ];
          };
          network = {
            format-wifi = "";
            format-ethernet = "";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "";
            format-disconnected = "⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };
          pulseaudio = {
            scroll-step = 1;
            format = "{volume}% {icon}";
            format-bluetooth = "{volume}% {icon}";
            format-bluetooth-muted = " {icon}";
            format-muted = "";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = "pavucontrol";
          };
        };

      };

      systemd = {
        enableDebug = true;
        enable = true;
      };
    };

  };
}
