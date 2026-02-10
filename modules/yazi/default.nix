{ minimal, inputs, ... }:
{
  nixpkgs.overlays =
    if minimal then
      [ ]
    else
      [
        inputs.yazi.overlays.default
      ];
  home-manager.users.cabero = {
    imports = [ ./hm.nix ];
  };
}
