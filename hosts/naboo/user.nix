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
    initialPassword = "1234";
    linger = true;
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
        todoist-electron
        google-chrome
        qalculate-gtk
        spotify
        vlc
        webtorrent_desktop
        insync
        obsidian
      ];
    };
    programs.home-manager.enable = true;
  };
}
