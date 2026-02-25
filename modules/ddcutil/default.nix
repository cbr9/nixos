{ pkgs, ... }:

{
  boot.kernelModules = [ "i2c-dev" ];
  # When an i2c device appears, let the i2c group touch it.
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  environment.systemPackages = [ pkgs.ddcutil ];
  users.groups.i2c = { };
  users.users.cabero.extraGroups = [ "i2c" ];
}
