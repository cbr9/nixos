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
        unfocused-split-opacity = 0.45;
        window-padding-x = 5;
        window-padding-y = 5;
        font-thicken = true;
        shell-integration = "fish";
        keybind = [
        ];
      };
    };
  };
}
