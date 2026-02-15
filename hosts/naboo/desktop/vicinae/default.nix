{ pkgs, ... }:
{
  home-manager.users.cabero = {
    programs.vicinae = {
      enable = true;
      package = pkgs.unstable.vicinae;
      settings = {
        faviconService = "twenty";
        font = {
          size = 10;
        };
        popToRootOnClose = false;
        rootSearch = {
          searchFiles = false;
        };
        theme = {
          name = "vicinae-dark";
        };
        window = {
          csd = true;
          opacity = 0.95;
          rounding = 10;
        };
      };
      systemd = {
        enable = true;
      };
      # extensions = [
      #   (config.lib.vicinae.mkExtension {

      #   })
      # ];
    };

  };
}
