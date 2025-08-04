{ pkgs, inputs, ... }:
{
  environment.persistence."/persist" = {
    # Link to the /persist mountpoint above
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/ssh"
      "/etc/cups"
      "/nix" # Crucial: the Nix store must be persistent
      "/var/log" # System logs
      "/var/lib/nix" # Nix database and other mutable state
      "/var/lib/nixos" # Nix database and other mutable state
      "/var/cache/nix" # Nix build cache (if you want to persist it)
      "/var/lib/bluetooth" # Bluetooth device pairings
      "/var/lib/NetworkManager" # Network configurations
      "/var/lib/colord"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];

    files = [
      "/etc/machine-id"
    ];
  };

  # --- User-specific Persistent Directories (for user 'cabero') ---
  # These directories will be stored under /persist/home/cabero/ and then
  # bind-mounted into /home/cabero/ on the ephemeral root.
  home-manager.users.cabero = {
    imports = [
      inputs.impermanence.homeManagerModules.impermanence
    ];

    home.packages = [ pkgs.fuse ];

    home.persistence."/persist/home/cabero" = {
      directories = [
        ".1password"
        ".1Password"
        ".cache/Insync/"
        ".cache/spotify"
        ".cache/fish/"
        ".cache/google-chrome/"
        ".cache/helix/"
        ".cache/nix/"
        ".cache/zellij/"
        ".cargo"
        ".config/1Password"
        ".config/Insync"
        ".config/google-chrome"
        ".config/kdeconnect"
        ".config/zellij"
        ".gnupg"
        ".local/share/Insync/"
        ".local/share/atuin"
        ".local/share/direnv"
        ".local/share/fish"
        ".local/share/keyrings"
        ".local/share/pueue"
        ".local/share/zoxide"
        ".ssh"
      ];
      allowOther = true;
    };
  };

  programs.fuse.userAllowOther = true;
}
