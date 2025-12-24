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
            command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
          }
          {
            timeout = 60 * 15;
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
        events = [
          {
            event = "before-sleep";
            command = "${pkgs.swaylock-effects}/bin/swaylock -f";
          }
        ];
      };
    };
  };
}
