{
  lib,
  inputs,
  config,
  isLinux ? false,
  isDarwin ? false,
  ...
}:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = {
    flakePath = config.flakePath;
    inherit
      inputs
      isLinux
      isDarwin
      ;
    nixosConfig = if isLinux then config else null;
    darwinConfig = if isDarwin then config else null;
  };
  home-manager.sharedModules = [
    inputs.nix-index-database.homeModules.nix-index
  ];
}
