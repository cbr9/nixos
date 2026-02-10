{
  inputs,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.helix.overlays.default
  ];
  home-manager.users.cabero = {
    imports = [ ./hm.nix ];
  };
}
