{ ... }:
{
  imports = [
    ../../../modules/tailscale
  ];

  networking.networkmanager.enable = true;
  networking = {
    iproute2.enable = true;
    enableIPv6 = true;
    dhcpcd.enable = true;
  };

  services.taildrop = {
    enable = true;
    directory = "/data/cabero/Downloads/Taildrop";
  };
}
