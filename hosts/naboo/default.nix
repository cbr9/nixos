{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./logitech.nix
    ./gnome.nix
    ./impermanence.nix
    ./secrets.nix
    ./../../modules/1password
    ./../../modules/bat
    ./../../modules/bottom
    ./../../modules/direnv
    ./../../modules/fish
    ./../../modules/fzf
    ./../../modules/git
    ./../../modules/helix
    ./../../modules/kdeconnect
    ./../../modules/lazygit
    ./../../modules/nix
    ./../../modules/nushell
    ./../../modules/pueue
    ./../../modules/spotify
    ./../../modules/ssh
    ./../../modules/starship
    ./../../modules/xdg
    ./../../modules/yazi
    ./../../modules/zoxide
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = ["i2c-dev"];
  system.stateVersion = "25.05";
  documentation.man.generateCaches = true;
  powerManagement.enable = true;

  environment = {
    pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw
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
