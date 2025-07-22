{ ... }:
{
  home-manager.users.cabero = {
    programs.lazygit = {
      enable = true;
      settings = {
        git = {
          overrideGpg = true;
          autoFetch = false;
        };
      };
    };
    home.shellAliases.lg = "lazygit";
  };
}
