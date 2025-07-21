{ lib, ... }:
{
  disko.devices = {
    disk = {
      sda = {
        device = "/dev/disk/by-uuid/FC78F29978F251BE";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            main = {
              type = "8302";
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home";
              };
            };
          };
        };
      };
      nvme0n1 = {
        device = "/dev/disk/by-id/nvme-eui.0025385901400dfa";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
