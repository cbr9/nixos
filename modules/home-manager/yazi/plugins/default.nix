{ pkgs, ... }:
{
  programs.yazi.plugins = with pkgs.unstable.yaziPlugins; {
    smart-filter = smart-filter;
    parent-arrow = ./parent-arrow.yazi;
    git = git;
    mime-ext = mime-ext;
  };
}
