{
  config,
  lib,
  isDarwin ? false,
  darwinConfig ? null,
  nixosConfig ? null,
  ...
}:
let
  systemConfig = if isDarwin then darwinConfig else nixosConfig;
  cfg = systemConfig.programs._1password;
  homeDir = config.home.homeDirectory;
  agent =
    if isDarwin then
      "${homeDir}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else
      "${homeDir}/.1password/agent.sock";

in
{
  home.sessionVariables = lib.optionalAttrs cfg.enable {
    SSH_AUTH_SOCK = agent;
  };
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      open-toadfish = {
        user = "cabero";
        hostname = "machine-shop-open-toadfish";
      };
      "*" = {
        forwardAgent = true;
        identityAgent = lib.mkIf cfg.enable [
          (lib.strings.escapeShellArg agent)
        ];
      };
    };
  };
}
