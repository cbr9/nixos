{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.services.hardware.openrgb;
in
with lib;
{
  options = {
    services.hardware.openrgb = {
      extraArgs = lib.mkOption {
        type = types.listOf types.str;
        default = [ ];
      };
    };
  };
}
