{
  config,
  lib,
  inputs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.impermanence.nixosModules.impermanence
  ];

  # services.udev.extraRules = ''
  #   ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x43ee" ATTR{power/wakeup}="disabled"
  # '';

  # boot.kernelParams = [
  #   "nvidia.NVreg_TemporaryFilePath=/var/tmp"
  #   "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  # ];
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "mem_sleep_default=deep"
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    fsType = "tmpfs";
    device = "none";
    options = [
      "defaults"
      "size=16G"
      "mode=755"
    ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/536883c7-c15b-4299-abb9-63fe5ef1fbfe"; # <--- UUID of your NVMe Btrfs pool
    fsType = "btrfs";
    neededForBoot = true;
    options = [
      "subvol=persist"
      "compress=zstd"
      "noatime"
    ]; # Mount the 'persist' subvolume
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/f9479f9b-915b-4b68-99d5-1abc7e5df6bb"; # <--- Replace with actual UUID
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/01E6-9825"; # <--- Replace with actual UUID
    fsType = "vfat";
  };

  environment.persistence."/persist" = {
    # Link to the /persist mountpoint above
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/ssh"
      "/etc/cups"
      "/nix" # Crucial: the Nix store must be persistent
      "/var/log" # System logs
      "/var/lib/nix" # Nix database and other mutable state
      "/var/lib/nixos" # Nix database and other mutable state
      "/var/cache/nix" # Nix build cache (if you want to persist it)
      "/var/lib/bluetooth" # Bluetooth device pairings
      "/var/lib/NetworkManager" # Network configurations
      "/var/lib/colord"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];

    files = [
      "/etc/machine-id"
    ];

  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp42s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # boot.loader.grub = {
  #   enable = lib.mkForce true;
  #   efiSupport =  true;
  #   useOSProber = true;
  #   device = "nodev";
  # };
  boot.loader = {
    efi.efiSysMountPoint = "/boot";
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      useOSProber = true;
      device = "nodev";
    };
  };
}
