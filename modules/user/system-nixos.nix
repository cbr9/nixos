{ pkgs, config, ... }:
{
  users.mutableUsers = true;

  users.users.cabero = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [
      "input"
      "wheel"
      "fuse"
      "plugdev"
      "seat"
      "docker"
      "scanner"
      "lp"
      "networkmanager"
    ];
    shell = pkgs.fish;
  };

  services.pcscd.enable = true;

  home-manager.users.cabero = {
    home.homeDirectory = "/home/${config.home-manager.users.cabero.home.username}";
    home.stateVersion = "25.11"; # This should align with your NixOS version
    home.pointerCursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      gtk.enable = true;
      x11.enable = true;
      size = 24;
    };
  };
}
