{...}: {
  imports = [
    ./cpu.nix
    ./gpu.nix
    ./audio.nix
    ./disk.nix
    ./bluetooth.nix
    ./net.nix
  ];
  hardware = {
    i2c.enable = true;
    sane.enable = true;
  };
}
