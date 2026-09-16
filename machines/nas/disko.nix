{ lib, ... }: {
  disko.devices = {
    disk = {
      "main" = {
        device = "/dev/disk/by-id/ata-KINGSTON_SA400S37480G_50026B7783C781FA";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
          };
        };
      };
    };
  };

  /*
    fileSystems."/persist".neededForBoot = true;
      # Automatic local snapshots
      # https://digint.ch/btrbk/doc/readme.html
      #$ systemctl start btrbk-<instance>
      services.btrbk = {
        instances."nix" = {
          onCalendar = "0/2:00";
          settings = {
            subvolume = "/nix";
            snapshot_create = "onchange";
            snapshot_dir = "/nix";
            snapshot_preserve = "16h 7d 2w";
            snapshot_preserve_min = "3d";
          };
        };
        instances."home" = {
          onCalendar = "0/2:00";
          settings = {
            subvolume = "/home";
            snapshot_create = "onchange";
            snapshot_dir = "/home";
            snapshot_preserve = "16h 7d 3w 2m";
            snapshot_preserve_min = "3d";
          };
        };
        instances."persist" = {
          onCalendar = "0/2:00";
          settings = {
            subvolume = "/persist";
            snapshot_dir = "/persist";
            snapshot_preserve = "16h 7d 3w 2m";
            snapshot_preserve_min = "3d";
          };
        };
      };
  */
}
