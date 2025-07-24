{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.services.desktopManager.gnome;
in
{
  services.flatpak.enable = true;

  services = {
    desktopManager = {
      gnome = {
        enable = true;
        debug = true;
      };
    };
    displayManager = {
      gdm = {
        enable = cfg.enable;
        debug = true;
      };
    };
  };
  environment.systemPackages = [ pkgs.wl-clipboard ];

  home-manager.users.cabero = {
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
    };
  };
}
