{
  pkgs,
  isDarwin ? false,
  ...
}:
{
  home-manager.users.cabero = {
    home.sessionVariables = {
      TERMINAL = "ghostty";
    };
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      package = if isDarwin then null else pkgs.ghostty;

      settings = {
        theme = "Gruvbox Dark";
        font-size = 17;
        font-family = "SauceCodePro NF";
        unfocused-split-opacity = 0.55;
        window-padding-x = 10;
        window-padding-y = 10;
        mouse-hide-while-typing = true;
        font-thicken = true;
        window-decoration = "none";
        cursor-style = "block";
        cursor-style-blink = false;
        cursor-click-to-move = true;
        shell-integration-features = "no-cursor";

        macos-option-as-alt = true;
        shell-integration = "fish";
        keybind = [
          "super+ctrl+arrow_down=resize_split:down,25"
          "super+ctrl+arrow_left=resize_split:left,25"
          "super+ctrl+arrow_right=resize_split:right,25"
          "super+ctrl+arrow_up=resize_split:up,25"
        ];
      };
    };
  };
}
