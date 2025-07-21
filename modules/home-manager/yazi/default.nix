{ pkgs, ... }:
{
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
    shellWrapperName = "yy";
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    initLua = ./init.lua;
    package = pkgs.unstable.yazi;
  };
}
