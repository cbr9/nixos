{ ... }:
{
  home-manager.users.cabero = {
    programs.atuin = {
      enable = true;
      daemon.enable = true;
      flags = [
        "--disable-up-arrow"
      ];
    };
  };
}
