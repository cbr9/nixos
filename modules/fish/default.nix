{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.fish.enable = true;
  documentation.man.generateCaches = lib.mkForce false;

  home-manager.users.cabero =
    let
      hm = config.home-manager.users.cabero;
    in
    {
      home.file = {
        ".config/fish/themes".source = ./themes;
      };

      programs.fish = {
        enable = true;
        generateCompletions = true;

        functions = {
          fish_user_key_bindings = ''
            # To find out what sequence a key combination sends, you can use fish_key_reader
            bind \el accept-autosuggestion  # alt+l
            bind \ek up-or-search # alt+k
            bind \ej down-or-search # alt+j
            bind \ce 'fish_commandline_prepend $EDITOR'
            bind \cw 'set old_tty (stty -g); stty sane; yy; stty $old_tty; commandline -f repaint'
          '';
        };

        shellInit =
          let
            HOME = "${hm.home.homeDirectory}";
          in
          ''
            set -g fish_greeting ""
            source ${HOME}/.config/fish/themes/gruvbox.fish
            theme_gruvbox dark medium



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
    };
}
