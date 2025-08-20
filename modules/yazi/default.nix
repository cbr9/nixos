{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [
    inputs.yazi.overlays.default
  ];
  home-manager.users.cabero = {
    imports = [
      ./plugins
      ./settings.nix
      ./keymap.nix
    ];

    home.packages = with pkgs; [
      exiftool
    ];
    programs.yazi = {
      enable = true;
      initLua = ./init.lua;
      package = pkgs.yazi;
    };
  };
}
