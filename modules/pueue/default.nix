{ ... }:
{
  home-manager.users.cabero = {
    services.pueue = {
      enable = true;
      settings = { };
    };
  };
}
