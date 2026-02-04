{
  config,
  inputs,
  lib,
  system,
  isLinux ? false,
  isDarwin ? false,
  ...
}:
let
  unfreeVar = {
    NIXPKGS_ALLOW_UNFREE = if config.nixpkgs.pkgs.config.allowUnfree then "1" else "0";
  };
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
// lib.optionalAttrs isLinux { environment.sessionVariables = unfreeVar; }
// lib.optionalAttrs isDarwin { environment.variables = unfreeVar; }
