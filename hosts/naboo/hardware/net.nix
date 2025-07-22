{ ... }:
{
  networking.networkmanager.enable = true;
  networking = {
    iproute2.enable = true;
    enableIPv6 = true;
    dhcpcd.enable = true;
  };
}
