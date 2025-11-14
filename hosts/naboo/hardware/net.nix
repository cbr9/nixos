{ pkgs, ... }:
rec {
  networking.networkmanager.enable = true;
  networking = {
    iproute2.enable = true;
    enableIPv6 = true;
    dhcpcd.enable = true;
  };
  networking.firewall.checkReversePath = "loose";
  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
    extraSetFlags = [
      "--operator=cabero"
      "--exit-node-allow-lan-access"
      "--exit-node=de-fra-wg-002.mullvad.ts.net"
    ];
  };

  systemd.services.taildrop =
    let
      taildropDir = "/data/cabero/Downloads/Taildrop";
    in
    {
      description = "Run taildrop in a loop";
      after = [ "tailscaled.service" ];
      wants = [ "tailscaled.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${services.tailscale.package}/bin/tailscale file get --conflict rename --verbose --loop ${taildropDir}";
      };
    };
}
