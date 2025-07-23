{ ... }:
{
  home-manager.users.cabero = {
    programs.zellij = {
      enable = true;
    };
    home.shellAliases.zj = "zellij";
  };
}
