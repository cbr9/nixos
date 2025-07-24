{ pkgs, config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  services.libinput.enable = true;

  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      forceFullCompositionPipeline = true;
      powerManagement.enable = true;
      open = false;
    };
    graphics = {
      enable = true;
      extraPackages = [
        pkgs.libva
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    d-spy
    glxinfo
    vulkan-headers
    vulkan-loader
    vulkan-tools
    xawtv
  ];
}
