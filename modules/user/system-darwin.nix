{ pkgs, config, ... }:
{
  # Define the user on macOS
  users.users.cabero = {
    name = "cabero";
    home = "/Users/cabero";
    shell = pkgs.fish;
  };

  home-manager.users.cabero = {
    home.homeDirectory = "/Users/${config.home-manager.users.cabero.home.username}";
    home.stateVersion = "23.11"; # This should align with your nix-darwin version or home-manager version
    # Pointer cursor settings for macOS might be different or not needed as much
    # services.xserver.pointerCursor.enable = false; # Not applicable for macOS
  };
}
