{ ... }:
{
  programs.yazi.keymap = {
    mgr.prepend_keymap = [
      {
        on = [ "K" ];
        run = "plugin parent-arrow -1";
      }
      {
        on = [ "J" ];
        run = "plugin parent-arrow 1";
      }
      {
        on = [ "z" ];
        run = "plugin zoxide";
      }
      {
        on = [ "Z" ];
        run = "plugin fzf";
      }
    ];
  };
}
