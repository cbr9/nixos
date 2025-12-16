{
  pkgs,
  lib,
  config,
  ...
}:
{
  home-manager.users.cabero = {
    home.packages = [ pkgs.git-crypt ];
    programs.delta = {

      enable = true;
      options = {
        hyperlinks = true;
        side-by-side = true;
        line-numbers = true;
        dark = true;
      };
      enableGitIntegration = true;
    };
    programs.git = {
      enable = true;
      delta = {
      };
      lfs.enable = true;

      ignores = [
        "*~"
        "*.swp"
      ];
      settings = {
        merge.conflictstyle = "diff3";
        core = {
          editor = "hx";
          autocrlf = "input";
        };
        init.defaultBranch = "main";
        gpg.format = "ssh";
        gpg."ssh".program =
          lib.mkIf config.programs._1password.enable "${config.programs._1password-gui.package}/bin/op-ssh-sign";
        commit.gpgsign = true;
        user.merge.tool = "meld";
        pull = {
          rebase = true;
        };
        push = {
          autoSetupRemote = true;
        };
        user = {
          signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOe0bugU6xBMHw8bIMlvEr9TnZ3S185UkTzRJUcmcW6v";
          name = "cbr9";
          email = "cabero96@gmail.com";
        };
      };
    };
  };
}
