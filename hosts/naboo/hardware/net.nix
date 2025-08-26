{ pkgs, ... }:
{
  networking.networkmanager.enable = true;
  networking = {
    iproute2.enable = true;
    enableIPv6 = true;
    dhcpcd.enable = true;
  };
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
