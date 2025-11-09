{ pkgs, ... }:
{
  services.libinput.enable = true;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    amdgpu = {
      initrd.enable = true;
    };
    graphics = {
      enable32Bit = true;
      enable = true;
      extraPackages = with pkgs; [
        libva
        amf
        mesa
      ];
    };
  };
  environment.systemPackages = [ pkgs.amdgpu_top ];
}
