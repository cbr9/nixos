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

    programs.fish.shellAbbrs = {
      lg = "lazygit";
    };
    programs.nushell.shellAliases = {
      lg = "lazygit";
    };
  };
}
