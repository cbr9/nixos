{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.shells = [ pkgs.nushell ];
  home-manager.users.cabero =
    let
      userAutoload = ".config/nushell/autoload";
    in
    {
      home.file = (
        (lib.createSymlinksForDirectory {
          sourceDir = ./nuutils;
          targetRelativePath = userAutoload;
        })
        // (lib.createSymlinksForDirectory {
          sourceDir = ./config;
          targetRelativePath = userAutoload;
        })
      );
      programs.nushell = {
        enable = true;
        settings = {
          show_banner = false;
        };
      };
    };
}
