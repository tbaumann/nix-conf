# Example to create a bios compatible gpt partition
{ lib, ... }:
{
  disko.devices = {
    disk.disk1 = {
      device = lib.mkDefault "/dev/sda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "btrfs";
              # BTRFS partition is not mounted as it doesn't set a mountpoint explicitly
              subvolumes = {
                # This subvolume will not be mounted
                "SYSTEM" = { };
                # mounted as "/"
                "SYSTEM/rootfs" = {
                  mountpoint = "/";
                };
                # mounted as "/nix"
                "SYSTEM/nix" = {
                  mountOptions = [ "compress=zstd" "noatime" ];
                  mountpoint = "/nix";
                };
                # This subvolume will not be mounted
                "DATA" = { };
                # mounted as "/home"
                "DATA/home" = {
                  mountOptions = [ "compress=zstd" ];
                  mountpoint = "/home";
                };
                # mounted as "/persist"
                "DATA/persist" = {
                  mountOptions = [ "compress=zstd" ];
                  mountpoint = "/persist";
                };
                "DATA/media" = {
                  mountOptions = [ "compress=zstd" ];
                  mountpoint = "/media";
                };
              };
            };
          };
        };
      };
    };
  };
}
