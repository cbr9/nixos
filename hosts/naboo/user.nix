{
  pkgs,
  config,
  ...
}:
{

  users.mutableUsers = true;

  users.users.cabero = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [
      "input"
      "wheel"
      "fuse"
      "plugdev"
      "seat"
      "docker"
      "scanner"
      "lp"
      "networkmanager"
    ];
    shell = pkgs.fish;
  };

  services.pcscd.enable = true;

  # home-manager.users.root = {
  #   programs.helix = config.home-manager.users.cabero.programs.helix;
  #   programs.yazi = config.home-manager.users.cabero.programs.yazi;
  #   home.stateVersion = config.home-manager.users.cabero.home.stateVersion;
  #   programs.home-manager.enable = true;
  # };

  home-manager.users.cabero = {
    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };
    };
    home = rec {
      homeDirectory = "/home/${username}";
      stateVersion = "25.05";
      username = "cabero";
      pointerCursor = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        gtk.enable = true;
        x11.enable = true;
        size = 24;
      };
      packages = with pkgs; [
        # CLI
        sops
        gemini-cli
        appimage-run
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
        playerctl
        devenv
        poppler-utils
        ripgrep
        sd
        # GUI
        gparted
        loupe
        adwaita-icon-theme
        anki-bin
        google-chrome
        qalculate-gtk
        unstable.spotify
        vlc
        unstable.keymapp
        webtorrent_desktop
        snapshot
        obsidian
      ];
    };
    programs.home-manager.enable = true;
  };
}
