{ pkgs, ... }:
{
  imports = [
    ./base
    ./fonts
    ./gnome.nix
    ./hardware
    ./hardware-configuration.nix
    ./impermanence.nix
    ./logitech.nix
    ./printing.nix
    # ./secrets.nix
    ./user.nix
    ./xdg.nix
    ../../modules/1password
    ../../modules/atuin
    ../../modules/bat
    ../../modules/bottom
    ../../modules/zellij
    ../../modules/kitty
    ../../modules/direnv
    ../../modules/fish
    ../../modules/fzf
    ../../modules/git
    ../../modules/helix
    ../../modules/kdeconnect
    ../../modules/lazygit
    ../../modules/nix
    ../../modules/nushell
    ../../modules/pueue
    ../../modules/nix-index
    # ../../modules/spotify
    ../../modules/ssh
    ../../modules/starship
    ../../modules/yazi
    ../../modules/zoxide
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "i2c-dev" ];
  system.stateVersion = "25.05";
  documentation.man.generateCaches = true;
  powerManagement.enable = true;

  environment = {
    pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  };

  networking.hostName = "naboo";
  environment.systemPackages = with pkgs; [
    killall
    git
    wget
    openssl
    libnotify
    pkg-config
    pavucontrol
    agenix
  ];
}
