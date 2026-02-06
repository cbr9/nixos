{
  pkgs,
  lib,
  isLinux ? false,
  ...
}:
{
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];

  home-manager.users.cabero = {
    imports = [ ./hm.nix ];
  };
}
// lib.optionalAttrs isLinux {
  documentation.man.generateCaches = lib.mkForce false;
}
