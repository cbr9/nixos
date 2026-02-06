{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.yazi.overlays.default
  ];

  home-manager.users.cabero = {
    imports = [ ./hm.nix ];
  };
}
