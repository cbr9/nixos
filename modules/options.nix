{ lib, ... }:
{
  options.flakePath = lib.mkOption {
    type = lib.types.str;
    description = "Path to the flake directory on this host";
  };
}
