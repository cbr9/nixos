{
  pkgs,
  config,
  lib,
  ...
}:
with pkgs;
with lib;
let
  cfg = config.sys.security;
in
{
  options.sys.security = {
    sshd.enable = mkOption {
      type = types.bool;
      description = "Enable sshd service on system";
      default = true;
    };
  };

  config = {
    security = {
      rtkit.enable = true;
      # Stops sudo from timing out.
      sudo = {
        enable = true;
        extraConfig = "Defaults env_reset,timestamp_timeout=-1";
        execWheelOnly = true;
      };
      polkit.enable = true;
    };

    # services.gnome.gnome-keyring.enable = true;

    services.openssh.enable = cfg.sshd.enable;
    networking.firewall.allowedTCPPorts = [
      (mkIf cfg.sshd.enable 22)
      8080
    ];
    networking.firewall.allowPing = true;

    # systemd = {
    #   user.services = {
    #     polkit-gnome-authentication-agent-1 = {
    #       description = "polkit-gnome-authentication-agent-1";
    #       wantedBy = [ "graphical-session.target" ];
    #       wants = [ "graphical-session.target" ];
    #       after = [ "graphical-session.target" ];
    #       serviceConfig = {
    #         Type = "simple";
    #         ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    #         Restart = "on-failure";
    #         RestartSec = 1;
    #         TimeoutStopSec = 10;
    #       };
    #     };
    #   };
    # };
  };
}
