{
  pkgs,
  lib,
  config,
  isDarwin,
  ...
}:
{
  home-manager.users.cabero = {
    imports = [ ./hm.nix ];
    programs.git.settings = {
      gpg.format = "ssh";
      gpg."ssh".program = lib.mkIf config.programs._1password.enable (
        if isDarwin then
          "${pkgs._1password-gui}/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
        else
          "${pkgs._1password-gui}/bin/op-ssh-sign"
      );
      commit.gpgsign = true;
    };
  };
}
