{
  inputs,
  system,
}:
let
  appOverlays = [
    inputs.helix.overlays.default
    inputs.yazi.overlays.default
  ];
in
import inputs.nixpkgs {
  inherit system;
  config = {
    allowUnfree = true;
  };
  overlays = [
    (final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    })
  ]
  ++ appOverlays;
}
