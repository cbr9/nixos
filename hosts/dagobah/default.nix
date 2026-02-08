{
  pkgs,
  lib,
  config,
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
    ../../modules/kitty
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

  # macOS system preferences
  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      mru-spaces = false; # Don't rearrange spaces based on recent use
      show-recents = false;
      tilesize = 48;
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXRemoveOldTrashItems = true;
      FXPreferredViewStyle = "clmv"; # Column view
      ShowExternalHardDrivesOnDesktop = false;
      ShowPathbar = true;
      ShowStatusBar = true;
      NewWindowTarget = "Home";
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3; # Full keyboard control
      ApplePressAndHoldEnabled = false; # Key repeat instead of accents
      InitialKeyRepeat = 10;
      KeyRepeat = 0;
      AppleShowAllExtensions = true;
      NSWindowShouldDragOnGesture = true;
      NSDocumentSaveNewDocumentsToCloud = false;
    };
    screencapture = {
      location = "${config.home-manager.users.cabero.home.homeDirectory}/Pictures/Screenshots";
    };
    trackpad = {
      Clicking = true; # Tap to click
      Dragging = true;
      DragLock = true;
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
      "google-chrome"
      "firefox"
      "notion"
    ];
  };
}
