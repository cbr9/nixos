{ ... }:
{
  programs.zoxide = {
    enable = true;
    options = [
      "--hook prompt"
    ];
  };
}
