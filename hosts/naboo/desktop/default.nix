{ pkgs, ... }:
{
  imports = [
    ./niri
    ./swayidle
    ./waybar
    ./vicinae
    ./wlogout
    ./swaylock
    ./wpaperd
  ];

  programs.xwayland.enable = true;
  services.flatpak.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    wl-clipboard
    papers
    apple-cursor
    xwayland-satellite
  ];

  home-manager.users.cabero = {
    services.swaync = {
      enable = true;
      settings = {
        positionX = "right";
        positionY = "top";
        layer = "overlay";
        control-center-layer = "top";
        layer-shell = true;
        cssPriority = "application";
        control-center-margin-top = 0;
        control-center-margin-bottom = 0;
        control-center-margin-right = 0;
        control-center-margin-left = 0;
        notification-2fa-action = true;
        notification-inline-replies = false;
        notification-icon-size = 64;
        notification-body-image-height = 100;
        notification-body-image-width = 200;

      };
      style =
        # css
        ''
          .notification-row {
            outline: none;
          }

          .notification {
            border-radius: 12px;
            padding: 5px;
          }
        '';

    };
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
