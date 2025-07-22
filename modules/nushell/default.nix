{ pkgs, ... }:
{
  environment.shells = [ pkgs.nushell ];
  home-manager.users.cabero = {
    programs.nushell = {
      enable = true;
      # configFile.source = ./config.nu;
    };
  };
}
