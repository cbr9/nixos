{
  pkgs,
  config,
  ...
}:
{

  users.mutableUsers = false;
  users.users.root.initialPassword = "1234";

  users.users.cabero = {
    createHome = true;
    isNormalUser = true;
    linger = true;
    initialPassword = "1234";
    extraGroups = [
      "input"
      "wheel"
      "fuse"
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
    home = rec {
      homeDirectory = "/home/${username}";
      stateVersion = "25.05";
      username = "cabero";
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
        poppler_utils
        ripgrep
        sd
        # GUI
        gparted
        google-chrome
        qalculate-gtk
        spotify
        vlc
        firefox-bin
        obs-studio
        webtorrent_desktop
        obsidian
      ];
    };
    programs.home-manager.enable = true;
  };
}
