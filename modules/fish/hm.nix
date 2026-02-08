{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/fish/themes".source = ./themes;
  };

  programs.fish = {
    enable = true;
    generateCompletions = true;

    # abbreviations
    preferAbbrs = true;
    shellAbbrs = {
      gp = "git push";
    };

    # keybindings
    binds = {
      "ctrl-e".command = "edit_command_buffer";
      "ctrl-w".command = "set old_tty (stty -g); stty sane; yy; stty $old_tty; commandline -f repaint";
      "alt-l".command = "accept-autosuggestion";
    };

    shellInit =
      let
        HOME = "${config.home.homeDirectory}";
      in
      # fish
      ''
        set -g fish_greeting ""

        fish_config theme choose "fish default"
        set -gx fish_cursor_visual block
        set -gx fish_color_command blue
        set -gx fish_color_autosuggestion 555

        set -gx fish_pager_color_selected_background --background=brblack

        if test -f ${HOME}/.nix-profile/etc/profile.d/nix.fish
          source ${HOME}/.nix-profile/etc/profile.d/nix.fish
        end

        if test -f ${HOME}/.config/op/plugins.sh
          source ${HOME}/.config/op/plugins.sh
        end
      '';

    plugins = with pkgs; [
      {
        # text expansions
        name = "puffer";
        src = fishPlugins.puffer.src;
      }
      {
        # text expansions
        name = "autopair";
        src = fishPlugins.autopair.src;
      }
    ];
  };
}
