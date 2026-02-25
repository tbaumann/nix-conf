{
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [
    "kvm-amd"
  ];
  boot.kernelParams = [
    #"badram=0x0000000fdbdaa7a8,0xfffffffffffffff8" "memmap=0x0000000fdbdaa7a8$0x0000000fdbdaa7af"
    "initcall_blacklist=dw_i2c_init_driver"
    "microcode.amd_sha_check=off"
  ];
  boot.blacklistedKernelModules = ["qcserial"];
  nix.settings.system-features = [
    "kvm"
    "big-parallel"
    "gccarch-znver2"
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
    ];
  };

  fileSystems."/" = {
    device = "/dev/nvme0n1p4";
    fsType = "btrfs";
    options = ["subvol=SYSTEM/rootfs"];
  };

  fileSystems."/nix" = {
    device = "/dev/nvme0n1p4";
    fsType = "btrfs";
    options = ["subvol=SYSTEM/nix"];
  };

  fileSystems."/home" = {
    device = "/dev/nvme0n1p4";
    fsType = "btrfs";
    options = ["subvol=DATA/home"];
  };
  fileSystems."/home-old" = {
    device = "/dev/nvme0n1p4";
    fsType = "btrfs";
    options = ["subvol=DATA/home-old"];
  };

  fileSystems."/persist" = {
    device = "/dev/nvme0n1p4";
    fsType = "btrfs";
    options = ["subvol=DATA/persist"];
  };

  /*
  fileSystems."/media" = {
    device = "/dev/nvme0n1p4";
    fsType = "btrfs";
    options = ["subvol=DATA/media"];
  };
  */

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/ESP";
    fsType = "vfat";
  };

  swapDevices = [
    {
      device = "/dev/disk/by-label/swap";
      #    randomEncryption.enable = true;  maybe not for suspend
    }
  ];
  boot.resumeDevice = "/dev/nvme0n1p3";
  nix.settings = {
    cores = 24;
  };
  networking.useDHCP = lib.mkDefault true;

  #  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  services.ucodenix = {
    enable = true;
    #FIXME Broken build, but sources contain microcode for this model-id
    #cpuModelId = "00830f10";
  };

  services.auto-cpufreq.enable = false;
}
