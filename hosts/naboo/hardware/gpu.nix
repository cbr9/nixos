{ pkgs, ... }:
{
  services.libinput.enable = true;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  hardware = {
    graphics = {
      enable32Bit = true;
      enable = true;
      extraPackages = with pkgs; [
        libva
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk

      ];
    };
  };

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  environment.systemPackages = with pkgs; [
    d-spy
    glxinfo
    vulkan-headers
    vulkan-loader
    vulkan-tools
    xawtv
  ];
}
