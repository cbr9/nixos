{
  inputs,
  lib,
  pkgs,
  isLinux ? false,
  isDarwin ? false,
  ...
}:
{
  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    gc = {
      automatic = true;
    }
    // lib.optionalAttrs isLinux {
      dates = "weekly";
    }
    // lib.optionalAttrs isDarwin {
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
    };
    settings = rec {
      max-jobs = 20;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "@wheel" ];

      # Add community Cachix to binary cache
      builders-use-substitutes = true;
      trusted-substituters = substituters;
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    }
    // lib.optionalAttrs isLinux {
      # Scans and hard links identical files in the store
      auto-optimise-store = true;
    };
  }
  // lib.optionalAttrs isDarwin {
    package = pkgs.lix;
    optimise.automatic = true;
  };
}
