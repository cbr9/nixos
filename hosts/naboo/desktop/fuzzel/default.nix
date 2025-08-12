{ ... }:
{
  home-manager.users.cabero = {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          dpi-aware = "no";
          fields = "filename,name";
          exit-on-keyboard-focus-loss = "yes";
          keyboard-focus = "on-demand";
          layer = "overlay";
        };
        colors = {
          background = "282a36ff";
          text = "f8f8f2ff";
          match = "8be9fdff";
          selection-match = "8be9fdff";
          selection = "44475add";
          selection-text = "f8f8f2ff";
          border = "bd93f9ff";
        };
      };
    };

  };
}
