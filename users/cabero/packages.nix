{ pkgs, ... }:
let
  cli = with pkgs; [
    agenix
    du-dust
    awscli
    dysk
    fd
    just
    ouch
    uv
    poppler_utils
    ripgrep
    sd
    sox
    typst
    watchexec
  ];

  gui = with pkgs; [
    appimage-run
    gparted
    google-chrome
    meld
    qalculate-gtk
    spotify
    vlc
    webtorrent_desktop
    insync
    obsidian
  ];
in
{
  home.packages = cli ++ gui;
}
