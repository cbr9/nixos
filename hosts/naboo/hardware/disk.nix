{ ... }:
{
  config = {
    services.udisks2.enable = true;
    services.devmon.enable = true;
    services.gvfs.enable = true;
    # For SSDs
    services.fstrim.enable = true;
  };
}
