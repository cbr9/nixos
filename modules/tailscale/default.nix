{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.services.taildrop;
in
{
  options.services.taildrop = {
    enable = lib.mkEnableOption "Taildrop file receiving service";
    directory = lib.mkOption {
      type = lib.types.str;
      description = "Directory to store received Taildrop files";
    };
  };

  config = {
    networking.firewall.checkReversePath = "loose";
    networking.firewall.trustedInterfaces = [ "tailscale0" ];

    services.tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
      extraSetFlags = [
        "--operator=cabero"
      ];
    };

    systemd.services.taildrop = lib.mkIf cfg.enable {
      description = "Run taildrop in a loop";
      after = [ "tailscaled.service" ];
      wants = [ "tailscaled.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${config.services.tailscale.package}/bin/tailscale file get --conflict rename --verbose --loop ${cfg.directory}";
      };
    };
  };
}
