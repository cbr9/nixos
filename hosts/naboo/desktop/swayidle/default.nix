{ pkgs, ... }:
{
  home-manager.users.cabero = {
    services = {
      swayidle = {
        enable = true;
        timeouts = [
          {
            timeout = 300; # 5 minutes
            command = "${pkgs.hyprlock}/bin/hyprlock";
          }
          {
            timeout = 900; # 15 minutes
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
        events = [
          {
            event = "before-sleep";
            command = "${pkgs.hyprlock}/bin/hyprlock";
          }
        ];
      };
    };
  };
}
