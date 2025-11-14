{ pkgs, ... }:
{
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];
  services.udev.packages = [ pkgs.sane-airscan ];
  hardware.sane.disabledDefaultBackends = [ "escl" ];

  hardware.sane.enable = true;
  services = {
    upower.enable = true;
    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = with pkgs; [
        cnijfilter2
        canon-cups-ufr2
        cups-filters
        cups-browsed
      ];
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
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Canon-Pixma-TS5150";
        location = "Home";
        deviceUri = "dnssd://Canon%20TS5100%20series._ipp._tcp.local/?uuid=00000000-0000-1000-8000-001825655a54";
        model = "canonts5100.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "Canon-Pixma-TS5150";
  };
}
