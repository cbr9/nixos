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
