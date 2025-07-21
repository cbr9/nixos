{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.helix;
in
{
  # home.sessionVariables = mkIf cfg.enable rec {
  #   # EDITOR = "${cfg.package}/bin/hx";
  #   VISUAL = EDITOR;
  #   SUDO_EDITOR = EDITOR;
  # };

  xdg.desktopEntries.Helix =
    lib.mkIf (cfg.enable && (builtins.hasAttr "TERMINAL" config.home.sessionVariables))
      {
        name = "Helix";
        genericName = "Helix";
        type = "Application";
        exec = "${config.home.sessionVariables.TERMINAL} -e ${cfg.package}/bin/hx %F";
        icon = "helix";
        startupNotify = false;
        terminal = false;
        categories = [
          "Utility"
          "TextEditor"
        ];
        mimeType = [
          "application/json"
          "application/x-shellscript"
          "text/english"
          "text/html"
          "text/plain"
          "text/x-c"
          "text/x-c++"
          "text/x-c++hdr"
          "text/x-c++src"
          "text/x-chdr"
          "text/x-csrc"
          "text/x-java"
          "text/x-makefile"
          "text/x-moc"
          "text/x-pascal"
          "text/x-tcl"
          "text/x-tex"
        ];
      };

  imports = [
    ./languages.nix
    ./settings.nix
  ];

  programs.helix = {
    enable = true;
    package = pkgs.unstable.helix;
    defaultEditor = true;
    extraPackages = with pkgs; [
      clippy
      nixd
      delve
      gopls
      lua-language-server
      marksman
      nil
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
}
