{ pkgs, ... }:
{
  home-manager.users.cabero = {
    imports = [
      ./plugins
      ./settings.nix
      ./keymap.nix
    ];

    home.packages = with pkgs; [
      exiftool
    ];
    programs.yazi =
      let
        themeName = "gruvbox-dark";
      in
      {
        enable = true;
        initLua = ./init.lua;
        package = pkgs.yazi;
        theme = {
          flavor.dark = themeName;
        };
        flavors =
          let
            gruvbox-dark = pkgs.fetchFromGitHub {
              repo = "${themeName}.yazi";
              owner = "bennyyip";
              rev = "91fdfa70f6d593934e62aba1e449f4ec3d3ccc90";
              sha256 = "sha256-RWqyAdETD/EkDVGcnBPiMcw1mSd78Aayky9yoxSsry4=";
            };
          in
          {
            gruvbox-dark = gruvbox-dark;
          };
      };
  };
}
