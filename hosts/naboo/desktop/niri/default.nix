{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.niri.overlays.default
  ];

  programs.niri = {
    enable = true;
  };
  services.displayManager.defaultSession = "niri";

  home-manager.users.cabero = {
    home.file.".config/niri/config.kdl".source = ./config.kdl;
    wayland.systemd.target = "niri.service";

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

  };
}
