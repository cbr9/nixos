{
  pkgs,
  lib,
  config,
  isDarwin,
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
        gpg."ssh".program = lib.mkIf config.programs._1password.enable (
          if isDarwin then
            "${pkgs._1password-gui}/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
          else
            "${pkgs._1password-gui}/bin/op-ssh-sign"
        );
        commit.gpgsign = true;
        pull = {
          rebase = true;
        };
        push = {
          autoSetupRemote = true;
        };
        url = {
          "ssh://git@ssh.github.com:443/" = {
            insteadOf = "git@github.com:";
          };
          "ssh://git@altssh.gitlab.com:443/" = {
            insteadOf = "git@gitlab.com:";
          };
        };

        user = {
          merge.tool = "meld";
        }
        // (
          if isDarwin then
            {
              signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA5Lnn2Qmi99Ynt89qRJIrmRfNBAwvVwBaBfkaSftzNB";
              name = "Andres Cabero Busto";
              email = "andres.busto@voize.de";
            }
          else
            {
              signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOe0bugU6xBMHw8bIMlvEr9TnZ3S185UkTzRJUcmcW6v";
              name = "cbr9";
              email = "cabero96@gmail.com";
            }
        );
      };
    };
  };
}
