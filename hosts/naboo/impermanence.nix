{ ... }:
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
  environment.persistence."/persist".users.cabero = {
    directories = [
      ".cargo"
      ".config/1Password"
      ".config/google-chrome"
      ".cache/Insync/"
      ".config/Insync/"
      ".local/share/Insync/"
      ".ssh"
      ".gnupg"
    ];
  };
}
