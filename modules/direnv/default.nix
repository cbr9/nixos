{ ... }:
{
  home-manager.users.cabero = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        global = {
          load_dotenv = true;
        };
      };
    };
  };
}
