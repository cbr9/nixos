{
  config,
  pkgs,
  inputs,
  lib,
  isLinux ? false,
  isDarwin ? false,
  ...
}:

let
  oldUv =
    (import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/01b6809f7f9d1183a2b3e081f0a1e6f8f415cb09.tar.gz";
      sha256 = "sha256:00z9fndpvv993bkzkn3hnmkhxqigb5n2g0l83r5l1i2i8n6d6d0d";
    }) { system = pkgs.stdenv.hostPlatform.system; }).uv;

  commonPackages = with pkgs; [
    # CLI tools
    sops
    gemini-cli
    glow
    devenv
    nixfmt-rfc-style
    cmake
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
    sd
    # GUI apps (cross-platform)
    adwaita-icon-theme
    anki-bin
    qalculate-gtk
    unstable.spotify
    unstable.keymapp
    obsidian
  ];

  linuxPackages = with pkgs; [
    appimage-run
    gparted
    loupe
    playerctl
    vlc
    webtorrent_desktop
    snapshot
  ];

  darwinPackages = with pkgs; [
    unstable.raycast
    android-tools
    unstable.jetbrains-toolbox
    claude-code
    alt-tab-macos
    betterdisplay
    oldUv
  ];
in
{
  home-manager.users.cabero = {
    gtk = lib.mkIf isLinux {
      enable = true;
      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };
    };
    home = {
      username = "cabero";
      packages =
        commonPackages ++ lib.optionals isLinux linuxPackages ++ lib.optionals isDarwin darwinPackages;
    };
    programs.home-manager.enable = true;
  };
}
