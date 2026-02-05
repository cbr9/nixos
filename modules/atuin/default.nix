{ ... }:
{
  home-manager.users.cabero = {
    programs.atuin = {
      enable = true;
      daemon.enable = false;
      flags = [
        "--disable-up-arrow"
      ];
    };
  };
}
