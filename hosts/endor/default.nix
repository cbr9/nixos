{
  pkgs,
  inputs,
  system,
  ...
}:
{
  flakePath = "/home/cabero/Code/nixos";

  # Use nixpkgs without helix/yazi overlays to avoid compiling from source
  nixpkgs.pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      })
    ];
  };

  imports = [
    ./hardware-configuration.nix
    ../../modules/atuin
    ../../modules/bottom
    ../../modules/direnv
    ../../modules/fish
    ../../modules/fzf
    ../../modules/git
    ../../modules/helix
    ../../modules/lazygit
    ../../modules/nix/nix.nix
    ../../modules/pueue
    ../../modules/nix-index
    ../../modules/ssh
    ../../modules/starship
    ../../modules/tailscale
    ../../modules/yazi
    ../../modules/zoxide
  ];

  services.paperless = {
    enable = true;
    address = "0.0.0.0";
  };

  # Boot
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  # Networking
  networking.hostName = "endor";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Locale
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # Security
  security.sudo = {
    enable = true;
    execWheelOnly = true;
  };

  # User
  users.mutableUsers = true;
  users.users.cabero = {
    createHome = true;
    linger = true; # without this services defined by HM won't work
    isNormalUser = true;
    extraGroups = [
      "input"
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.fish;
  };

  home-manager.users.cabero = {
    home.username = "cabero";
    home.homeDirectory = "/home/cabero";
    home.stateVersion = "25.11";
    home.pointerCursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      gtk.enable = true;
      size = 24;
    };
    home.sessionVariables.TERMINAL = "alacritty";
    programs.home-manager.enable = true;
    programs.alacritty.enable = true;
    services.syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
      settings = {
      };
    };
  };

  # Taildrop
  services.taildrop = {
    enable = true;
    directory = "/home/cabero/Downloads/Taildrop";
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    killall
    htop
  ];

  # Graphical specialisation
  specialisation.graphical.configuration = {
    imports = [
      ../naboo/desktop/swayidle
      ../naboo/desktop/swaylock
      ../naboo/desktop/wlogout
      ../naboo/desktop/wpaperd
    ];

    programs.niri.enable = true;
    services.displayManager.defaultSession = "niri";
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
          user = "greeter";
        };
      };
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    home-manager.users.cabero = {
      home.file.".config/niri/config.kdl".source = ../naboo/desktop/niri/config.kdl;
    };

    environment.systemPackages = with pkgs; [
      firefox
      wl-clipboard
    ];
  };

  system.stateVersion = "25.11";
}
