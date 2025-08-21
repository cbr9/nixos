{
  inputs,
  system,
  ...
}:
let
in
{
  nixpkgs.pkgs = import inputs.nixpkgs rec {
    inherit system;
    config = {
      allowUnfree = true;
      rocmSupport = true;
    };
    overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit system config;
        };
      })
    ];
  };
}
