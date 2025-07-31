{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.services.desktopManager.gnome;
in
{
  services.flatpak.enable = true;

  programs.niri.enable = true;
  programs.hyprlock.enable = true;

  services = {
    desktopManager = {
      gnome = {
        enable = true;
        debug = true;
      };
    };
    displayManager = {
      defaultSession = "niri";
      gdm = {
        enable = cfg.enable;
        debug = true;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    wl-clipboard
    papers
    apple-cursor
    kitty
  ];

  nix.settings = {
    substituters = [
      "https://walker-git.cachix.org"
      "https://walker.cachix.org"
    ];
    trusted-public-keys = [
      "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
    ];
  };

  security.pam.services.swaylock = { };
  home-manager.users.cabero = {
    imports = [
      inputs.walker.homeManagerModules.default
    ];

    programs.walker = {
      enable = true;
      runAsService = true;

      # All options from the config.json can be used here.
      config = {
        search.placeholder = "Example";
        ui.fullscreen = true;
        list = {
          height = 200;
        };
        websearch.prefix = "?";
        switcher.prefix = "/";
      };

      # # If this is not set the default styling is used.
      # theme.style = ''
      #   * {
      #     color: #dcd7ba;
      #   }
      # '';
    };
    services.cliphist = {
      enable = true;
    };
    services.swww = {
      enable = true;
    };
    programs.swaylock = {
      enable = true;
    };
    programs.waybar = {
      enable = true;
    };
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          dpi-aware = "yes";
          fields = "filename,name";
          terminal = "${pkgs.kitty}/bin/kitty";
          layer = "overlay";
        };
        colors.background = "ffffffff";
      };
    };
    home = {
      file.".config/gnome-initial-setup-done" = {
        source = pkgs.writeText "gnome-initial-setup-done" "yes";
        force = true;
        enable = cfg.enable;
      };
      file.".config/monitors.xml" = {
        source = ./monitors.xml;
        force = true;
        enable = cfg.enable;
      };
    };

    dconf.settings = lib.mkIf cfg.enable {
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
      };
      "org/gnome/GWeather4" = {
        temperature-unit = "centigrade";
      };
      "org/gnome/desktop/input-sources" = {
        per-window = true;
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/shell" = {
        favorite-apps = [
          "google-chrome.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Console.desktop"
        ];
        welcome-dialog-last-shown-version = "48.2";
      };
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-schedule-automatic = false;
        night-light-schedule-from = 20.0;
        night-light-schedule-to = 6.0;
      };
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
        picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
        primary-color = "#241f31";
        secondary-color = "#000000";
      };
      "org/gnome/desktop/screensaver" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
        picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
        primary-color = "#241f31";
        secondary-color = "#000000";
      };

      "org/gnome/Console" = {
        use-system-font = false;
        custom-font = "CaskaydiaCove Nerd Font Mono 12";
      };

      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "nothing";
      };

      "org/freedesktop/tracker/miner/files" = {
        index-recursive-directories = [
          "&DESKTOP"
          "&DOCUMENTS"
          "&MUSIC"
          "&PICTURES"
          "&VIDEOS"
          "/data"
        ];
      };

      "org/gnome/desktop/break-reminders" = {
        selected-breaks = [
          "eyesight"
          "movement"
        ];
        "movement/duration-seconds" = 180;
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        send-events = "disabled";
      };
    };
  };
}
