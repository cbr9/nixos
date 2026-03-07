{
  config,
  lib,
  isDarwin ? false,
  darwinConfig ? null,
  nixosConfig ? null,
  ...
}:
let
in
{
  # home.sessionVariables = lib.mkIf (agent != "") {
  #   SSH_AUTH_SOCK = agent;
  # };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      open-toadfish = {
        user = "cabero";
        hostname = "machine-shop-open-toadfish";
      };
      naboo = {
        user = "cabero";
        hostname = "naboo";
      };
      endor = {
        user = "cabero";
        hostname = "endor";
        compression = true;
        controlMaster = "auto";
        controlPath = "~/.ssh/sockets/%r@%h-%p";
        controlPersist = "600";
      };
      "*" = {
        forwardAgent = true;
      };
    };
  };
}
