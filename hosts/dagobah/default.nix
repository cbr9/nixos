{
  pkgs,
  lib,
  ...
}:

{
  flakePath = "/Users/cabero/Code/nixos";
  imports = [
    # General-purpose modules from naboo
    ../../modules/1password
    ../../modules/atuin
    ../../modules/awscli
    ../../modules/bat
    ../../modules/bottom
    ../../modules/direnv
    ../../modules/fish
    ../../modules/fzf
    ../../modules/gh # Assuming gh is general purpose
    ../../modules/git
    ../../modules/helix
    ../../modules/lazygit
    ../../modules/nix
    ../../modules/nix-index
    ../../modules/nushell
    ../../modules/pueue
    ../../modules/ssh
    ../../modules/starship
    ../../modules/yazi
    ../../modules/zellij
    ../../modules/zoxide

    # User module (includes home, system-darwin)
    ../../modules/user
  ];

  # Set your system.stateVersion - this should be specific to your darwin setup
  system.stateVersion = 4;
  system.primaryUser = "cabero";

  # Match existing Nix installation GID
  ids.gids.nixbld = 350;

  # fish shell
  programs.fish.enable = true;

  # Command Line Tools (CLT)
  # You might need to enable this if your macOS system needs them, refer to nix-darwin docs
  # programs.command-line-tools.enable = true;

  networking.hostName = "dagobah"; # Set your hostname

  # Used for system-wide environment variables (you might want to populate this)
  environment.systemPath = [ ];

  # Set the Nixpkgs channel to use
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Keyboard settings
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = false;
  };

  # macOS system preferences
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false; # Don't rearrange spaces based on recent use
      show-recents = false;
      tilesize = 48;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv"; # Column view
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3; # Full keyboard control
      ApplePressAndHoldEnabled = false; # Key repeat instead of accents
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      AppleShowAllExtensions = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
    trackpad = {
      Clicking = true; # Tap to click
      TrackpadThreeFingerDrag = true;
    };
  };

  # Fonts
  fonts.packages =
    with pkgs;
    [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
    ]
    ++ (builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts));

  # Homebrew integration (for GUI apps not in nixpkgs or casks)
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Remove unlisted casks/formulae
    };
    casks = [
      "iina" # Video player
      "rectangle" # Window management
      "notion-calendar"
      "notion-mail"
      "notion"
    ];
  };
}
