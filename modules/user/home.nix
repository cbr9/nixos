{
  config,
  pkgs,
  lib,
  isLinux ? false,
  isDarwin ? false,
  ...
}:

let
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
    uv
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
    # macOS-specific packages can be added here
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
