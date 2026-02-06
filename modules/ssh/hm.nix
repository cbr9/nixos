{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = true;
      };
      machine-shop-open-toadfish = {
        user = "cabero";
      };
    };
  };
}
