{
  config,
  lib,
  pkgs,
  inputs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.impermanence.nixosModules.impermanence
  ];

  services.udev.extraRules = ''
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x43ee" ATTR{power/wakeup}="disabled"
  '';

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
    options = ["size=6G"];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/YOUR_NVME_BTRFS_UUID"; # <--- UUID of your NVMe Btrfs pool
    fsType = "btrfs";
    options = [ "subvol=persist" "compress=zstd" "noatime" ]; # Mount the 'persist' subvolume
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/YOUR_4TB_HDD_UUID"; # <--- Replace with actual UUID
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" ]; 
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/YOUR_EFI_PARTITION_UUID"; # <--- Replace with actual UUID
    fsType = "vfat";
  };

  environment.persistence."/persist" = { # Link to the /persist mountpoint above
      directories = [
        "/nix"             # Crucial: the Nix store must be persistent
        "/var/log"         # System logs
        "/var/lib/nix"     # Nix database and other mutable state
        "/var/cache/nix"   # Nix build cache (if you want to persist it)
        "/var/lib/bluetooth" # Bluetooth device pairings
        "/var/lib/NetworkManager" # Network configurations
        "/var/lib/colord"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];

      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ecdsa_key"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_rsa_key"
        # Add any other system-wide files you need to persist
        { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
      ];

      # --- User-specific Persistent Directories (for user 'cabero') ---
      # These directories will be stored under /persist/home/cabero/ and then
      # bind-mounted into /home/cabero/ on the ephemeral root.
      users.cabero = {
        directories = [
          ".cargo"
          ".config/google-chrome"
          ".ssh"
          ".gnupg"
          ".password-store"
          ".cache/wal"
          ".config/awesome"
          ".wallpaper"
          ".screenlayout.sh"
          ".bash_history"
          ".zsh_history"
        ];
      };
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
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      useOSProber = true;
      device = "nodev";
    };
  };
}
