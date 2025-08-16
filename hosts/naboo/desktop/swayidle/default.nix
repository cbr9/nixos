{ pkgs, ... }:
{
  home-manager.users.cabero = {
    services = {
      swayidle = {
        enable = true;
        timeouts = [
          {
            timeout = 300; # 5 minutes
            command = "${pkgs.swaylock-effects}/bin/swaylock -f";
          }
          {
            timeout = 330;
            command = "${pkgs.niri}/bin/niri msg output DP-2 off && ${pkgs.niri}/bin/niri msg output DP-3 off";
            resumeCommand = "${pkgs.niri}/bin/niri msg output DP-2 on && ${pkgs.niri}/bin/niri msg output DP-3 on";
          }
          {
            timeout = 900; # 15 minutes
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
        events = [
          {
            event = "before-sleep";
            command = "${pkgs.swaylock-effects}/bin/swaylock -f";
          }
          {
            event = "after-resume";
            command = "${pkgs.niri}/bin/niri msg output DP-2 on && ${pkgs.niri}/bin/niri msg output DP-3 on";
          }
        ];
      };
    };
  };
}
