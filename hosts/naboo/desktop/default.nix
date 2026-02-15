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
    services.dunst = {
      enable = true;
    };
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
