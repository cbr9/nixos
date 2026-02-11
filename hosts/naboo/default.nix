{ pkgs, ... }:
{
  flakePath = "/data/cabero/Code/dotfiles";
  imports = [
    ./base
    ./fonts
    ./desktop
    ./hardware
    ./hardware-configuration.nix
    ./printing.nix
    ./xdg.nix
    ../../modules/user
    ../../modules/1password
    ../../modules/atuin
    ../../modules/bat
    ../../modules/bottom
    ../../modules/awscli
    ../../modules/zellij
    ../../modules/ghostty
    ../../modules/direnv
    ../../modules/fish
    ../../modules/fzf
    ../../modules/git
    ../../modules/helix
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

  programs.gamescope = {
    enable = true;
  };
  programs.steam = {
    enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "i2c-dev" ];
  system.stateVersion = "25.11";
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

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    storageDriver = "btrfs";
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
    gamescope
    nautilus
  ];
}
