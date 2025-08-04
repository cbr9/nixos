{ pkgs, ... }:
let
  width = "100";
  fuzzel = ''fuzzel --dmenu --prompt "> Clipboard: " --width ${width}'';
  cliphist-list = ''cliphist -preview-width ${width} list'';

  select-from-clipboard = pkgs.writeShellScriptBin "select-from-clipboard" ''
    ${cliphist-list} | ${fuzzel} | cliphist decode | wl-copy
  '';
  delete-from-clipboard = pkgs.writeShellScriptBin "delete-from-clipboard" ''
    ${cliphist-list} | ${fuzzel} | cliphist delete
  '';
in
{
  home-manager.users.cabero = {
    home.packages = [
      select-from-clipboard
      delete-from-clipboard
    ];
  };
}
