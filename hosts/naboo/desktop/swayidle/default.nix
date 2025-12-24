{ pkgs, ... }:
let
  suspendDelay = 15;
in

{
  home-manager.users.cabero = {
    services = {
      swayidle = {
        enable = true;
        timeouts = [
          {
            timeout = 60 * (suspendDelay / 3);
            command = "${pkgs.swaylock-effects}/bin/swaylock -f";
          }
          {
            timeout = 60 * (suspendDelay / 2);
            command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
          }
          {
            timeout = 60 * suspendDelay;
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

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleSleepKey = "suspend";
    HandleSuspendKey = "suspend";
  };

  # Define time delay for hibernation
  systemd.sleep.extraConfig = ''
    SuspendState=mem
  '';
}
