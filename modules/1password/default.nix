{
  pkgs,
  config,
  lib,
  isLinux ? false,
  isDarwin ? false,
  ...
}:
let
  cfg = config.programs._1password;
in
{
  programs = {
    _1password.enable = true;
  }
  // lib.optionalAttrs isLinux {
    # Only manage 1Password GUI on Linux; on macOS install via App Store or Homebrew
    _1password-gui = {
      enable = cfg.enable;
      package = pkgs.unstable._1password-gui;
      polkitPolicyOwners = [ "cabero" ];
    };
  };
}
