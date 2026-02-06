{
  config,
  pkgs,
  lib,
  isLinux ? false,
  isDarwin ? false,
  ...
}:

let
  oldPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/01b6809f7f9d1183a2b3e081f0a1e6f8f415cb09.tar.gz";
    sha256 = "sha256:00z9fndpvv993bkzkn3hnmkhxqigb5n2g0l83r5l1i2i8n6d6d0d";
  }) { system = pkgs.system; };
  commonPackages = with pkgs; [
    # CLI tools
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
    # GUI apps (cross-platform)
    adwaita-icon-theme
    anki-bin
    alacritty
    google-chrome
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
    alt-tab-macos
    betterdisplay
    oldPkgs.uv
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
