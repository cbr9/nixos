{
  inputs,
  system,
  extraOverlays ? [ ],
  includeAppOverlays ? true,
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
    rocmSupport = true;
  };
  overlays = [
    (final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    })
  ]
  ++ (if includeAppOverlays then appOverlays else [ ])
  ++ extraOverlays;
}
