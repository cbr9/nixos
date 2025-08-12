{ pkgs, ... }:
{
  imports = [
    ./base
    ./fonts
    ./desktop
    ./hardware
    ./hardware-configuration.nix
    ./impermanence.nix
    ./logitech.nix
    ./printing.nix
    ./user.nix
    ./xdg.nix
    ../../modules/1password
    ../../modules/atuin
    ../../modules/bat
    ../../modules/bottom
    ../../modules/awscli
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
    ../../modules/ssh
    ../../modules/starship
    ../../modules/yazi
    ../../modules/zoxide
  ];

  boot.kernelModules = [ "i2c-dev" ];
  system.stateVersion = "25.05";
  documentation.man.generateCaches = true;
  powerManagement.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.libinput.enable = true;
  environment = {
    pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  };

  networking.hostName = "naboo";
  environment.systemPackages = with pkgs; [
    killall
    simple-scan
    git
    wget
    openssl
    libnotify
    pkg-config
    pavucontrol
    nautilus
  ];
}
