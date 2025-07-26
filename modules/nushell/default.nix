{ lib, pkgs, ... }:
{
  environment.shells = [ pkgs.nushell ];
  home-manager.users.cabero = {
    home.file = lib.createSymlinksForDirectory {
      sourceDir = ./nuutils;
      targetRelativePath = ".config/nushell/autoload";
    };
    programs.nushell = {
      enable = true;
      settings = {
        show_banner = false;
      };
      # configFile.source = ./config.nu;
    };
  };
}
