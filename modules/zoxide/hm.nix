{ ... }:
{
  programs.zoxide = {
    enable = true;
    options = [
      "--hook pwd"
    ];
  };
}
