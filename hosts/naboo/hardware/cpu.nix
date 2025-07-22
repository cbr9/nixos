{ pkgs, ... }:
{
  boot = {
    kernelModules = [
      "kvm-amd"
    ];
  };

  environment.systemPackages = [
    pkgs.microcodeAmd
  ];

  virtualisation.libvirtd.enable = true;
}
