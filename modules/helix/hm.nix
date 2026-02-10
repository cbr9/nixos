{
  config,
  pkgs,
  inputs,
  lib,
  minimal,
  ...
}:
{
  nixpkgs.overlays = lib.mkIf (!minimal) [
    inputs.helix.overlays.default
  ];

  home.sessionVariables = rec {
    VISUAL = "${config.programs.helix.package}/bin/hx";
    SUDO_EDITOR = VISUAL;
  };

  imports = [
    ./languages.nix
    ./settings.nix
  ];

  programs.ruff = {
    enable = true;
    settings = {
      line-length = 120;
    };
  };

  programs.helix = {
    enable = true;
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
      typescript-language-server
      unstable.ruff
      unstable.ty
      shellcheck
      taplo
      rust-analyzer
      lldb
      tinymist
    ];
  };
}
