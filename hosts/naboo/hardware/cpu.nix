{ pkgs, ... }:
{
  boot = {
    kernelModules = [
      "kvm-amd"
    ];
  };

  environment.systemPackages = [
    pkgs.microcode-amd
  ];

  virtualisation.libvirtd.enable = true;
}
