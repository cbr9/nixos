{ pkgs, ... }:
{
  imports = [
    ./clipboard
    ./emoji
    ./niri
    ./swayidle
    ./waybar
    ./fuzzel
    ./wlogout
  ];

  programs.xwayland.enable = true;
  services.flatpak.enable = true;
  services.xserver.displayManager.ly.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    wl-clipboard
    papers
    apple-cursor
    kitty
    bemoji
    xwayland-satellite
  ];

  home-manager.users.cabero = {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        font-size = 36;
        clock = true;
        indicator = true;
        indicator-radius = 100;
        indicator-thickness = 7;
        effect-blur = 2;
        effect-pixelate = 100;
        screenshots = true;
        indicator-idle-visible = false;
        show-failed-attempts = true;
        show-keyboard-layout = true;
        color = "24273a";
        bs-hl-color = "f4dbd6";
        caps-lock-bs-hl-color = "f4dbd6";
        caps-lock-key-hl-color = "a6da95";
        inside-color = "00000000";
        inside-clear-color = "00000000";
        inside-caps-lock-color = "00000000";
        inside-ver-color = "00000000";
        inside-wrong-color = "00000000";
        key-hl-color = "a6da95";
        layout-bg-color = "00000000";
        layout-border-color = "00000000";
        layout-text-color = "cad3f5";
        line-color = "00000000";
        line-clear-color = "00000000";
        line-caps-lock-color = "00000000";
        line-ver-color = "00000000";
        line-wrong-color = "00000000";
        ring-color = "b7bdf8";
        ring-clear-color = "f4dbd6";
        ring-caps-lock-color = "f5a97f";
        ring-ver-color = "8aadf4";
        ring-wrong-color = "ee99a0";
        separator-color = "00000000";
        text-color = "cad3f5";
        text-clear-color = "f4dbd6";
        text-caps-lock-color = "f5a97f";
        text-ver-color = "8aadf4";
        text-wrong-color = "ee99a0";
      };
    };

    services.dunst = {
      enable = true;
    };
    services.cliphist = {
      enable = true;
    };
    services.swww = {
      enable = true;
    };
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
