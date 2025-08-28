{
  config,
  inputs,
  system,
  ...
}:
let
in
{
  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = if config.nixpkgs.pkgs.config.allowUnfree then "1" else "0";
  };

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
