{
  config,
  lib,
  ...
}:
let
  cfg = config.programs._1password;
  agent = "${config.home-manager.users.cabero.home.homeDirectory}/.1password/agent.sock";
in
{
  home-manager.users.cabero = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          forwardAgent = true;
        };
      };
      extraConfig = lib.optionalString cfg.enable "IdentityAgent ${agent}";
    };
  };
}
