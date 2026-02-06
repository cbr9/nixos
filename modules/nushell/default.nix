{
  pkgs,
  ...
}:
{
  environment.shells = [ pkgs.nushell ];
  home-manager.users.cabero = {
    imports = [ ./hm.nix ];
  };
}
