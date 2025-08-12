{ pkgs, ... }:
let
  width = "100";
  fuzzel = ''${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt "> Clipboard: " --width ${width}'';
  cliphist = "${pkgs.cliphist}/bin/cliphist";

  select-from-clipboard = pkgs.writeShellScriptBin "select-from-clipboard" ''
    ${cliphist} -preview-width ${width} list | ${fuzzel} | ${cliphist} decode | wl-copy
  '';
  delete-from-clipboard = pkgs.writeShellScriptBin "delete-from-clipboard" ''
    ${cliphist} -preview-width ${width} list | ${fuzzel} | ${cliphist} delete
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
