{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    # ./disks.nix
    # ./openrgb.nix
    ./logitech.nix
    ./gnome.nix
  ];

  programs.fuse.userAllowOther = true;
}
