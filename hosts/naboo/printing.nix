{ pkgs, ... }:
{
  services = {
    upower.enable = true;
    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = [ pkgs.cnijfilter2 ];
      cups-pdf.enable = false;
      startWhenNeeded = true;
      browsing = true;
      browsedConf = ''
        BrowseDNSSDSubTypes _cups,_print
        BrowseLocalProtocols all
        BrowseRemoteProtocols all
        CreateIPPPrinterQueues All
        BrowseProtocols all
      '';
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
