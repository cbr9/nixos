{ lib, pkgs, ... }:
{
  config = {
    programs.fish.enable = true;
    documentation.man.generateCaches = lib.mkForce false;
    environment.shells = [ pkgs.fish ];
    environment.pathsToLink = [ "/share/fish" ];
  };
}
