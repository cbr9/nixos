{
  config,
  lib,
  pkgs,
  flakePath,
  ...
}:
let
  flake = "(builtins.getFlake \"${flakePath}\")";
  oldPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/01b6809f7f9d1183a2b3e081f0a1e6f8f415cb09.tar.gz";
    sha256 = "sha256:00z9fndpvv993bkzkn3hnmkhxqigb5n2g0l83r5l1i2i8n6d6d0d";
  }) { system = pkgs.system; };

in
{
  imports = [
    ../../modules/atuin/hm.nix
    ../../modules/awscli/hm.nix
    ../../modules/bash/hm.nix
    ../../modules/bat/hm.nix
    ../../modules/bottom/hm.nix
    ../../modules/direnv/hm.nix
    ../../modules/fish/hm.nix
    ../../modules/fzf/hm.nix
    ../../modules/gh/hm.nix
    ../../modules/git/hm.nix
    ../../modules/lazygit/hm.nix
    ../../modules/nix-index/hm.nix
    ../../modules/nushell/hm.nix
    ../../modules/pueue/hm.nix
    ../../modules/ssh/hm.nix
    ../../modules/starship/hm.nix
    ../../modules/zellij/hm.nix
    ../../modules/zoxide/hm.nix
    ../../modules/helix/hm.nix
    ../../modules/yazi/hm.nix
  ];

  home = {
    username = "cabero";
    homeDirectory = "/home/cabero";
    stateVersion = "25.11";

    packages =
      with pkgs;
      [
        sops
        gemini-cli
        glow
        nixfmt-rfc-style
        just
        dust
        ffmpeg
        sox
        unstable.typst
        watchexec
        dysk
        dua
        fd
        ouch
        devenv
        poppler-utils
        ripgrep
        claude-code
        sd
      ]
      ++ [ oldPkgs.uv ];
  };

  programs = {
    home-manager.enable = true;

    # Override helix nixd config for this host
    helix.languages.language-server.nixd = {
      command = "nixd";
      args = [ ];
      config.nixd = {
        nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
        formatting.command = [ "nixfmt" ];
        options = {
          home-manager.expr = lib.mkForce "${flake}.homeConfigurations.machine-shop.options";
        };
      };
    };
  };
}
