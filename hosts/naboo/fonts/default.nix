{ pkgs, lib, ... }:
{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };
}
