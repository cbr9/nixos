{ pkgs, ... }:
{
  home-manager.users.cabero = {
    home.sessionVariables = {
      TERMINAL = "${pkgs.ghostty-bin}/bin/ghostty";
    };
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      package = pkgs.ghostty-bin;

      settings = {
        theme = "Gruvbox Dark";
        font-size = 17;
        font-family = "SauceCodePro NF";
        font-thicken = true;
        shell-integration = "fish";
        keybind = [
        ];
      };
    };
  };
}
