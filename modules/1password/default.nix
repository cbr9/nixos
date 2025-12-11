{ pkgs, config, ... }:
let
  cfg = config.programs._1password;
in
{
  programs = {
    _1password.enable = true;
    _1password-gui = {
      enable = cfg.enable;
      package = pkgs.unstable._1password-gui;
      polkitPolicyOwners = [ "cabero" ];
    };
  };
}
