{ inputs, lib, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
  ];

  # SD card root filesystem
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
