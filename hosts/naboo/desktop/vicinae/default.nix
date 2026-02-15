{ pkgs, inputs, ... }:
{
  home-manager.users.cabero = {
    programs.vicinae = {
      enable = true;
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
          name = "Gruvbox Dark";
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
      extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        bluetooth
        nix
        niri
        wifi-commander
      ];
    };

  };
}
