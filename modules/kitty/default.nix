{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.home-manager.users.cabero.programs.kitty;
in
with lib;
{
  home-manager.users.cabero = {
    home.sessionVariables = mkIf cfg.enable {
      TERMINAL = "${cfg.package}/bin/kitty";
    };

    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
      settings = {
        confirm_os_window_close = 0;
        editor = "${config.home-manager.users.cabero.home.sessionVariables.EDITOR}";
        window_padding_width = 5;
        cursor_blink_interval = 0;
        tab_bar_edge = "bottom";
        tab_bar_min_tabs = 2;
      };
      extraConfig = ''
        mouse_map right press ungrabbed mouse_select_command_output
      '';
      font = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydaCove Nerd Font Mono";
        size = 12;
      };
      themeFile = "GruvboxMaterialDarkMedium";
    };

    xdg.configFile = {
      "kitty/mime.types" = {
        enable = cfg.enable;
        text = ''
          text/plain lock nix json
        '';
      };
      # Make kitty open file hyperlinks with xdg-open when clicking
      # Since it doesn't seem to be the default behaviour
      "kitty/open-actions.conf" = {
        enable = cfg.enable;
        text = ''
          # Open any file with a fragment in helix, fragments are generated
          # by the hyperlink_grep kitten and nothing else so far.
          protocol file
          fragment_matches [0-9]+
          action launch --type=overlay --cwd=current hx ''${FILE_PATH}:''${FRAGMENT}

          # Open text files without fragments in the editor
          protocol file
          mime text/*
          action launch --type=overlay --cwd=current ''${EDITOR} ''${FILE_PATH}

          # Open text files without fragments in the editor
          protocol file
          file justfile
          action launch --type=overlay --cwd=current ''${EDITOR} ''${FILE_PATH}

          protocol file
          mime inode/directory
          action launch --type=overlay lf ''${FILE_PATH}

          protocol file
          mime image/*
          action launch --type=overlay kitten icat --hold ''${FILE_PATH}

          protocol ssh
          # Open ssh URLs with ssh command
          action launch --type=os-window kitten ssh ''${URL}
        '';
      };
    };
  };

}
