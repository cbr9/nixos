{
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.programs._1password-gui = {
    sshAgent = mkEnableOption "1Password SSH Agent" // {
      default = true;
    };
  };
  config = {
    programs = {
      _1password.enable = true;
      _1password-gui = {
        package = pkgs.unstable._1password-gui;
        enable = true;
        polkitPolicyOwners = [ "cabero" ];
      };
    };
  };
}
