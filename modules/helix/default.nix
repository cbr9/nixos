{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home-manager.users.cabero.programs.helix;
in
{
  home-manager.users.cabero = {
    home.sessionVariables = rec {
      VISUAL = "${cfg.package}/bin/hx";
      SUDO_EDITOR = VISUAL;
    };

    imports = [
      ./languages.nix
      ./settings.nix
    ];

    programs.helix = {
      enable = true;
      package = pkgs.helix;
      defaultEditor = true;
      extraPackages = with pkgs; [
        clippy
        delve
        gopls
        lua-language-server
        marksman
        nixfmt-rfc-style
        nodePackages.bash-language-server
        nodePackages.vscode-json-languageserver
        nodePackages.yaml-language-server
        ruff
        shellcheck
        taplo
        rust-analyzer
        lldb
        tinymist
      ];
    };
  };
}
