{ lib, ... }:

{
  home-manager.users.cabero = {
    programs.fzf = {
      enable = true;
      defaultOptions =
        let
          formatBindings =
            attrs:
            let
              # Map over the attribute names (keys) of the set
              pairs = lib.attrsets.mapAttrsToList (name: value: "${name}:${value}") attrs;
            in
            # Join the resulting "key:value" strings with commas
            builtins.concatStringsSep "," pairs;

          keybindings = {
            tab = "toggle-out";
            shift-tab = "toggle-in";
          };

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
          "--bind ${formatBindings keybindings}"
        ];
    };
  };
}
