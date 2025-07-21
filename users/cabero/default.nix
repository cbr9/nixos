{
  pkgs,
  config,
  ...
}:
{
  users.users.cabero = {
    createHome = true;
    isNormalUser = true;
    initialPassword = "1234";
    extraGroups = [
      "wheel"
      "fuse"
      "docker"
      "scanner"
      "lp"
      "networkmanager"
    ];
    shell = pkgs.fish;
  };

  age.secrets = {
    cabero-15582531.file = ../../secrets/cabero-15582531.age; # keychain
    cabero-15582547.file = ../../secrets/cabero-15582547.age; # loose
  };

  security.pam.yubico = {
    enable = true;
    debug = false;
    mode = "challenge-response";
    id = [
      "15582547"
      "15582531"
    ];
    challengeResponsePath = "/run/agenix";
  };

  services.pcscd.enable = true;

  home-manager.users.root = {
    programs.helix = config.home-manager.users.cabero.programs.helix;
    programs.yazi = config.home-manager.users.cabero.programs.yazi;
    home.stateVersion = config.home-manager.users.cabero.home.stateVersion;
    # stylix.targets = config.home-manager.users.cabero.stylix.targets;
    programs.home-manager.enable = true;
  };

  # --- User-specific Persistent Directories (for user 'cabero') ---
  # These directories will be stored under /persist/home/cabero/ and then
  # bind-mounted into /home/cabero/ on the ephemeral root.
  environment.persistence."/persist".users.cabero = {
    directories = [
      ".cargo"
      ".config/1Password"
      ".config/google-chrome"
      ".cache/Insync/"
      ".config/Insync/"
      ".local/share/Insync/"
      ".ssh"
      ".gnupg"
    ];
  };

  home-manager.users.cabero = rec {
    imports = [
      ../../modules/home-manager
      ./packages.nix
    ];
    home = {
      homeDirectory = "/home/${home.username}";
      stateVersion = "25.05";
      file.".config/gnome-initial-setup-done" = {
        source = pkgs.writeText "gnome-initial-setup-done" "yes";
        force = true;
      };
      file.".config/monitors.xml" = {
        source = ./monitors.xml;
        force = true;
      };
    };
    programs.home-manager.enable = true;
    home.username = "cabero";

    # GNOME CONFIG
    dconf.settings = {
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
