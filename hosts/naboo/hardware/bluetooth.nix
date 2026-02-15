{ ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Fixes pairing and connection loops
        Privacy = "device";
        JustWorksRepairing = "always";
        Class = "0x000100";
        FastConnectable = true;
      };
      LE = {
        MinConnectionInterval = 7;
        MaxConnectionInterval = 9;
        ConnectionLatency = 0;
      };
    };

    input = {
      General = {
        UserspaceHID = true;
      };
    };
  };

  # Enable the xpadneo driver (Advanced Xbox controller driver)
  hardware.xpadneo.enable = true;

  # Optional: Enable Blueman for a graphical Bluetooth manager
  services.blueman.enable = true;

  boot.extraModprobeConfig = ''
    options bluetooth disable_ertm=1
  '';
}
