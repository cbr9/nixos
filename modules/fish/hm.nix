{
  config,
  darwinConfig ? null,
  nixosConfig ? null,
  pkgs,
  isDarwin ? false,
  ...
}:
let

  systemConfig = if isDarwin then darwinConfig else nixosConfig;
  cfg = systemConfig.programs._1password;
  homeDir = config.home.homeDirectory;
  agent =
    if darwinConfig != null && cfg.enable then
      "${homeDir}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else if nixosConfig != null && cfg.enable then
      "${homeDir}/.1password/agent.sock"
    else
      "";
in
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
         # If SSH_AUTH_SOCK is NOT already set (meaning we are NOT in an SSH session),
         #   # then point it to the local 1Password agent socket.
            if not set -q SSH_AUTH_SOCK
              set -gx SSH_AUTH_SOCK "${agent}"
            end

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
