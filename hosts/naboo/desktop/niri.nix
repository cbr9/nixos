{
  pkgs,
  ...
}:
{
  services.flatpak.enable = true;

  programs.niri.enable = true;
  programs.hyprlock.enable = true;

  services = {
    displayManager = {
      defaultSession = "niri";
      ly.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    papers
    apple-cursor
    kitty
  ];

  home-manager.users.cabero = {
    home.file.".config/niri/config.kdl".source = ./config.kdl;
    services.dunst = {
      enable = true;
    };
    services.cliphist = {
      enable = true;
    };
    services.swww = {
      enable = true;
    };
    programs.waybar = {
      enable = true;
      style =
        # css
        ''
          * {
              /* `otf-font-awesome` is required to be installed for icons */
              font-family: "CaskaydiaMono Nerd Font Mono", 'Font Awesome 6 Free';
              font-size: 16px;
              font-feature-settings: "tnum";
          }

          window#waybar {
              background: transparent;
              /* background-color: rgba(30, 30, 46, 0.5); */
              /* border-bottom: 2px solid rgba(147, 153, 178, 0.5); */
              /* border: 1px solid rgba(166, 173, 200, 1.0); */
              color: #ffffff;
              /* transition-property: background-color; */
              /* transition-duration: .5s; */
          }

          window#waybar.hidden {
              opacity: 0.2;
          }

          /*
          window#waybar.empty {
              background-color: transparent;
          }
          window#waybar.solo {
              background-color: #FFFFFF;
          }
          */

          window#waybar.termite {
              background-color: #3F3F3F;
          }

          window#waybar.chromium {
              background-color: #000000;
              border: none;
          }

          button {
              /* Use box-shadow instead of border so the text isn't offset */
              box-shadow: none;
              /* Avoid rounded borders under each button name */
              border: none;
              border-radius: 0;
              transition-property: none;
          }

          /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
          button:hover {
              background: none;
              box-shadow: none;
              text-shadow: none;
              border: none;
              -gtk-icon-effect: none;
              -gtk-icon-shadow: none;
          }

          #workspaces button {
              padding: 0 5px;
              background-color: transparent;
              color: #ffffff;
          }

          #workspaces button:hover {
              background: rgba(0, 0, 0, 0.2);
          }

          #workspaces button.focused {
              background-color: #64727D;
              box-shadow: inset 0 -3px #ffffff;
          }

          #workspaces button.urgent {
              background-color: #eb4d4b;
          }

          #mode {
              background-color: #64727D;
              border-bottom: 3px solid #ffffff;
          }

          #clock,
          #battery,
          #cpu,
          #memory,
          #disk,
          #temperature,
          #backlight,
          #network,
          #pulseaudio,
          #wireplumber,
          #custom-media,
          #keyboard-state,
          #window,
          #language,
          #tray,
          #mode,
          #idle_inhibitor,
          #scratchpad,
          #mpd {
              padding: 0 15px;
              color: #f0f0ff;
              background-color: rgba(30, 30, 46, 0.6);
              border-radius: 20px;
          }

          /* #window, */
          #workspaces {
              margin: 0 4px;
          }

          /* If workspaces is the leftmost module, omit left margin */
          .modules-left > widget:first-child > #workspaces {
              margin-left: 0;
          }

          /* If workspaces is the rightmost module, omit right margin */
          .modules-right > widget:last-child > #workspaces {
              margin-right: 0;
          }

          #clock {
              /* background-color: #64727D; */
              font-weight: bold;
              /* background-color: rgba(0, 0, 0, 0.3); */
              border-radius: 99px;
          }

          #battery {
              /* background-color: #f9e2af; */
              /* color: #000000; */
              margin-left: 4px;
          }

          /*
          #battery.charging, #battery.plugged {
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
              background-color: #f53c3c;
              color: #ffffff;
              animation-name: blink;
              animation-duration: 0.5s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
          }
          */

          label:focus {
              background-color: #000000;
          }

          #cpu {
              /* background-color: #f38ba8; */
              /* color: #000000; */
              /* border-radius: 99px 0px 0px 99px; */
              /* padding: 0 0 0 10px; */
              /* padding: 4px; */
          }

          #memory {
              /* background-color: #fab387; */
              /* color: #000000; */
              /* border-radius: 0px 99px 99px 0px; */
              /* padding: 0 10px 0 0; */
          }

          #disk {
              background-color: #964B00;
          }

          #backlight {
              background-color: #90b1b1;
          }

          #network {
              /* background-color: #a6e3a1; */
              /* color: #000000; */
              font-size: 23px;
          }

          #network.disconnected {
              background-color: #f53c3c;
          }

          #taskbar {
              margin-left: 4px;
          }

          #taskbar button {
              color: #f0f0ff;
              background-color: rgba(30, 30, 46, 0.6);
          }

          #taskbar button:first-child {
              border-radius: 99px 0 0 99px;
          }

          #taskbar button:last-child {
              border-radius: 0 99px 99px 0;
          }

          #taskbar button:first-child:last-child {
              border-radius: 99px;
          }

          #taskbar button:hover {
              background-color: rgba(49, 50, 68, 0.6);
          }

          #taskbar button.active {
              background-color: rgba(88, 91, 112, 0.8);
          }

          #taskbar button.active:hover {
              background-color: rgba(108, 112, 134, 0.6);
          }

          #pulseaudio {
              background-color: #f1c40f;
              color: #000000;
          }

          #pulseaudio.muted {
              background-color: #90b1b1;
              color: #2a5c45;
          }

          #wireplumber {
              background-color: #fff0f5;
              color: #000000;
          }

          #wireplumber.muted {
              background-color: #f53c3c;
          }

          #custom-media {
              background-color: #66cc99;
              color: #2a5c45;
              min-width: 100px;
          }

          #custom-media.custom-spotify {
              background-color: #66cc99;
          }

          #custom-media.custom-vlc {
              background-color: #ffa000;
          }

          #temperature {
              background-color: #f0932b;
          }

          #temperature.critical {
              background-color: #eb4d4b;
          }

          #tray > .passive {
              -gtk-icon-effect: dim;
          }

          #tray > .needs-attention {
              -gtk-icon-effect: highlight;
              background-color: #eb4d4b;
          }

          #idle_inhibitor {
              background-color: #2d3436;
          }

          #idle_inhibitor.activated {
              background-color: #ecf0f1;
              color: #2d3436;
          }

          #mpd {
              background-color: #66cc99;
              color: #2a5c45;
          }

          #mpd.disconnected {
              background-color: #f53c3c;
          }

          #mpd.stopped {
              background-color: #90b1b1;
          }

          #mpd.paused {
              background-color: #51a37a;
          }

          #language {
              /*
              background: #00b093;
              color: #740864;
              */
              padding: 0 5px;
              margin: 0 5px;
              min-width: 16px;
          }

          #keyboard-state {
              padding: 0 0px;
              margin: 0 5px;
              min-width: 18px;
          }

          #keyboard-state > label {
              padding: 0 6px;
          }

          #keyboard-state > label.locked {
              background: #97e1ad;
              color: #000000;
              border-radius: 20px;
          }

          #scratchpad {
              background: rgba(0, 0, 0, 0.2);
          }

          #scratchpad.empty {
          	background-color: transparent;
          }

        '';
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
            "niri/language"
          ];

          "niri/language" = {
            format = "{short}";
          };

          "niri/window" = {
            # icon = true;
            separate-outputs = true;
            expand = true;
          };

          "wlr/taskbar" = {
            all-outputs = false;
            format = "{icon}";
            tooltip-format = "{title} | {app_id}";
            active_first = true;
            on-click = "activate";
            on-click-middle = "close";
            on-click-right = "fullscreen";
          };

          keyboard-state = {
            numlock = false;
            capslock = true;
            format = "{name} {icon}";
            format-icons = {
              locked = "";
              unlocked = "";
            };
          };
          tray = {
            icon-size = 21;
            spacing = 10;
            show-passive-items = true;
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
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          dpi-aware = "no";
          fields = "filename,name";
          exit-on-keyboard-focus-loss = "yes";
          terminal = "${pkgs.kitty}/bin/kitty";
          layer = "overlay";
        };
        colors = {
          background = "282a36ff";
          text = "f8f8f2ff";
          match = "8be9fdff";
          selection-match = "8be9fdff";
          selection = "44475add";
          selection-text = "f8f8f2ff";
          border = "bd93f9ff";
        };
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

  };
}
