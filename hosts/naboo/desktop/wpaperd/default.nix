{ ... }:
{
  home-manager.users.cabero = {
    services.wpaperd = {
      enable = true;
      settings.any = {
        path = "~/Pictures/Wallpapers";
      };
    };
  };
}
