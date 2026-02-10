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
    if darwinConfig != null && cfg.enable then
      "${homeDir}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else if nixosConfig != null && cfg.enable then
      "${homeDir}/.1password/agent.sock"
    else
      "";
in
{
  home.sessionVariables = {
    SSH_AUTH_SOCK = if agent == "" then "/home/cabero/.ssh/ssh_auth_sock" else agent;
  };
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      open-toadfish = {
        user = "cabero";
        hostname = "machine-shop-open-toadfish";
      };
      machine-shop-enjoyed-quetzal = {
        user = "cabero";
        hostname = "machine-shop-enjoyed-quetzal";
      };
      "*" = {
        forwardAgent = true;
        identityAgent = lib.mkIf (agent != "") [
          (lib.strings.escapeShellArg agent)
        ];
      };
    };
  };
}
