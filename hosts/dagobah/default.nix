# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  pkgs,
  lib,
  ...
}:
let
  certificate = /etc/nixos/certificate.pem;
  windowsUser = "H0UB8WV";
  stateVersion = "25.05";
in
{
  imports = [
    ../../modules/1password
    ../../modules/atuin
    ../../modules/bat
    ../../modules/bottom
    ../../modules/direnv
    ../../modules/fish
    ../../modules/fzf
    ../../modules/git
    ../../modules/helix
    ../../modules/lazygit
    ../../modules/nix
    ../../modules/nix
    ../../modules/nushell
    ../../modules/pueue
    ../../modules/ssh
    ../../modules/starship
    ../../modules/yazi
    ../../modules/zoxide
  ];

  home-manager.users.cabero = {
    home.stateVersion = stateVersion;
    programs.git = {
      extraConfig = {
        user = {
          email = lib.mkForce "acaberobusto@solventum.com";
          name = lib.mkForce "Andrés Cabero Busto";
        };
        gpg."ssh".program =
          lib.mkForce "/mnt/c/Users/${windowsUser}/AppData/Local/1Password/app/8/op-ssh-sign-wsl";
        core.hooksPath = "~/scm/main/core/langDev/tools/githooks";
      };
    };
    home.packages = with pkgs; [
      awscli
      glow
      conan
      ant
      dysk
      fd
      ouch
      poppler_utils
      ripgrep
      sd
    ];
  };

  programs.nix-ld.enable = true;
  users.users.cabero = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  environment.shellAliases = {
    ssh-add = "ssh-add.exe";
    ssh = "ssh.exe";
    op = "op.exe";
  };

  programs._1password.enable = lib.mkForce false;

  programs.java = {
    enable = true;
    package = pkgs.temurin-bin;
  };

  wsl = {
    enable = true;
    defaultUser = "cabero";
    docker-desktop.enable = true;
  };

  security.pki.certificates = [
    (builtins.readFile certificate)
  ];

  environment.sessionVariables = {
    DEVTOOLS = "/home/cabero/scm/main/core/devTools";
  };

  environment.sessionVariables = {
    NIX_SSL_CERT_FILE = certificate;
    NODE_EXTRA_CA_CERTS = certificate;
    REQUESTS_CA_BUNDLE = certificate;
    CURL_CA_BUNDLE = certificate;
    AWS_CA_BUNDLE = certificate;
    SSL_CERT_FILE = certificate;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = stateVersion; # Did you read the comment?
}
