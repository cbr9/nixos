{ pkgs, ... }:
{
  home-manager.users.cabero = {
    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        package = pkgs.unstable.nix-direnv;
      };
      config = {
        global = {
          load_dotenv = true;
        };
      };
    };
  };
}
