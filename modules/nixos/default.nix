{ pkgs, ... }:
{
  imports = [
    ./1password
    ./spotify
    ./base
    ./fish
    ./fonts
    ./hardware
    ./kdeconnect
    ./nix
    ./nushell
    # ./openrgb
  ];

  environment = {
    systemPackages = with pkgs; [
      killall
      git
      wget
      autorandr
      openssl
      libnotify
      pkg-config
      xclip
      pavucontrol
    ];
  };
}
