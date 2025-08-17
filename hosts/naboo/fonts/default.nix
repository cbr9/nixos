{ pkgs, lib, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };
}
