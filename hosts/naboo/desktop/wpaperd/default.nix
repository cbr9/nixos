{ pkgs, ... }:
{
  home-manager.users.cabero = {
    services.wpaperd = {
      enable = true;
      settings = {
        DP-2 = {
          path = pkgs.fetchurl {
            url = "https://unsplash.com/photos/FqPkHwRn5x8/download?ixid=M3wxMjA3fDB8MXxhbGx8Njl8fHx8fHx8fDE3NTU0NzE0MTN8&force=true";
            name = "wallpaper.jpg";
            sha256 = "sha256-hFj2YbLiKY1bu60MhTMmEMvK2EttjTis3jSSWjFHd48=";
          };
        };
        DP-3 = {
          path = pkgs.fetchurl {
            url = "https://unsplash.com/photos/0o_GEzyargo/download?ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNzU1NDY5NzA4fA";
            name = "wallpaper.jpg";
            sha256 = "sha256-ETk1GG7iUPNkAIkXHAAxBDANnkulQA7m4EI22m8PJ+g=";
          };
        };
      };
    };
  };
}
