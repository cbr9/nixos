{ pkgs, ... }:
let
  officialPlugins = pkgs.fetchFromGitHub {
    repo = "plugins";
    owner = "yazi-rs";
    rev = "de53d90cb2740f84ae595f93d0c4c23f8618a9e4";
    sha256 = "sha256-ixZKOtLOwLHLeSoEkk07TB3N57DXoVEyImR3qzGUzxQ=";
  };
in
{
  programs.yazi.plugins = {
    smart-filter = builtins.toPath "${officialPlugins}/smart-filter.yazi";
    parent-arrow = ./parent-arrow.yazi;
    git = builtins.toPath "${officialPlugins}/git.yazi";
  };
}
