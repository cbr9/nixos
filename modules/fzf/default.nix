{ lib, ... }:
{
  home-manager.users.cabero = {
    programs.fzf = {
      enable = true;
      defaultOptions =
        let
          walkerSkip = [
            ".git"
            ".direnv"
            "node_modules"
            "target"
            "__pycache__"
          ];
        in
        [
          "--walker-skip=${lib.strings.concatStringsSep "," walkerSkip}"
        ];
    };
  };
}
