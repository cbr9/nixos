{ ... }:
{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings = rec {
      max-jobs = 20;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "@wheel" ];

      # # Add community Cachix to binary cache
      builders-use-substitutes = true;
      trusted-substituters = substituters;
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
        "https://helix.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      ];

      # Scans and hard links identical files in the store
      auto-optimise-store = true;
    };
  };
}
