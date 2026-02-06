{
  config,
  lib,
  isDarwin ? false,
  ...
}:
let
  cfg = config.programs._1password;
  homeDir = config.home-manager.users.cabero.home.homeDirectory;
  agent =
    if isDarwin then
      "${homeDir}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else
      "${homeDir}/.1password/agent.sock";
in
{
  home-manager.users.cabero = {
    imports = [ ./hm.nix ];
    home.sessionVariables = lib.optionalAttrs cfg.enable {
      SSH_AUTH_SOCK = agent;
    };

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          forwardAgent = true;
        };
        machine-shop-open-toadfish = {
          user = "cabero";
          hostname = "machine-shop-open-toadfish";
        };
      };
      extraConfig = lib.optionalString cfg.enable "IdentityAgent \"${agent}\"";
    };
  };
}
