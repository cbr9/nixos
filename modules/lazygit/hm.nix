{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        sideColWidthPrec = 0.45;
        scrollPastBottom = true;
        scrollOffMargin = 5;
      };
      git = {
        overrideGpg = true;
        autoFetch = true;
        pages = [
          {
            colorArg = "always";
            pager = "delta --dark --paging=never";
          }
        ];
      };
    };
  };

  programs.fish.shellAbbrs = {
    lg = "lazygit";
  };
  programs.nushell.shellAliases = {
    lg = "lazygit";
  };
}
