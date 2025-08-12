{ pkgs, ... }:
{
  home-manager.users.cabero = {
    home.sessionVariables = {
      BEMOJI_PICKER_CMD = "fuzzel --dmenu";
    };
    home.packages = [ pkgs.bemoji ];
  };
}
