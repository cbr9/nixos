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
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        yzhang.markdown-all-in-one
        esbenp.prettier-vscode
        file-icons.file-icons
        dracula-theme.theme-dracula
        jnoortheen.nix-ide
        ms-python.python
        ms-toolsai.jupyter
        antfu.icons-carbon
        rust-lang.rust-analyzer
        file-icons.file-icons
        kamikillerto.vscode-colorize
        ms-vscode-remote.remote-ssh
        mechatroner.rainbow-csv
        donjayamanne.githistory
        davidanson.vscode-markdownlint
        bbenoist.nix
      ];
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
        webtorrent_desktop
        obsidian
      ];
    };
    programs.home-manager.enable = true;
  };
}
