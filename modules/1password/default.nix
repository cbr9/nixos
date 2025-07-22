{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs._1password;
in
{
  config = {
    programs = {
      _1password.enable = true;
      _1password-gui = {
        package = pkgs.unstable._1password-gui;
        enable = cfg.enable;
        polkitPolicyOwners = [ "cabero" ];
      };
    };
  };
}
