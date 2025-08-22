{ pkgs, ... }:
{
  home-manager.users.cabero = {
    services = {
      swayidle = {
        enable = true;
        timeouts = [
          {
            timeout = 60 * 5;
            command = "${pkgs.swaylock-effects}/bin/swaylock -f";
          }
          {
            timeout = 60 * 10;
            command = "${pkgs.niri}/bin/niri msg output DP-2 off && ${pkgs.niri}/bin/niri msg output DP-3 off";
            resumeCommand = "${pkgs.niri}/bin/niri msg output DP-2 on && ${pkgs.niri}/bin/niri msg output DP-3 on";
          }
          {
            timeout = 60 * 60;
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
        events = [
          {
            event = "before-sleep";
            command = "${pkgs.niri}/bin/niri msg output DP-2 on && ${pkgs.niri}/bin/niri msg output DP-3 on && ${pkgs.swaylock-effects}/bin/swaylock -f";
          }
          {
            # without this, if you resume the system and the monitors are set to use another video input, like HDMI
            # (say you are using your work laptop with the same monitors, but using a different input source),
            # the screens won't output anything, even after you switch the input back to DP
            event = "after-resume";
            command = "${pkgs.niri}/bin/niri msg output DP-2 on && ${pkgs.niri}/bin/niri msg output DP-3 on";
          }
        ];
      };
    };
  };
}
