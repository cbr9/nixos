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

  home-manager.users.root = {
    programs.helix = config.home-manager.users.cabero.programs.helix;
    programs.yazi = config.home-manager.users.cabero.programs.yazi;
    home.stateVersion = config.home-manager.users.cabero.home.stateVersion;
    programs.home-manager.enable = true;
  };

  home-manager.users.cabero = {
    programs.ruff = {
      enable = true;
      settings = {
        line-length = 120;
      };
    };
    programs.vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
      mutableExtensionsDir = true;
    };
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
        kalker
        nixfmt-rfc-style
        just
        du-dust
        ffmpeg
        sox
        uv
        typst
        watchexec
        dysk
        fd
        ouch
        playerctl
        devenv
        poppler_utils
        ripgrep
        sd
        # GUI
        gparted
        adwaita-icon-theme
        audacity
        google-chrome
        qalculate-gtk
        spotify
        vlc
        unstable.keymapp
        firefox-bin
        obs-studio
        webtorrent_desktop
        obsidian
      ];
    };
    programs.home-manager.enable = true;
  };
}
