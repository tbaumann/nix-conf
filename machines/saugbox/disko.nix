# ---
# schema = "single-disk"
# [placeholders]
# mainDisk = "/dev/disk/by-id/ata-HFS120G32TND-N1A0A_EJ74N155711204G0Z"
# ---
# This file was automatically generated!
# CHANGING this configuration requires wiping and reinstalling the machine
{

  disko.devices = {
    disk = {
      main = {
        name = "main-c753e4a43a6948dbbbb0d7b13fb5b289";
        device = "/dev/disk/by-id/ata-HFS120G32TND-N1A0A_EJ74N155711204G0Z";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            "boot" = {
              size = "1M";
              type = "EF02"; # for grub MBR
              priority = 1;
            };
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
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
