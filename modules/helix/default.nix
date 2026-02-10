{
  minimal,
  inputs,
  ...
}:
{
  nixpkgs.overlays =
    if (minimal) then
      [ ]
    else
      [
        inputs.helix.overlays.default
      ];
  home-manager.users.cabero = {
    imports = [ ./hm.nix ];
  };
}
