{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd" "kvm-intel"];
  boot.kernelParams = ["badram=0x0000000fdbdaa7a8,0xfffffffffffffff8" "memmap=0x0000000fdbdaa7a8$0x0000000fdbdaa7af" "memtest=2" "amd_prefcore=enable"];
  boot.blacklistedKernelModules = ["qcserial"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  nix.settings.system-features = [
    "kvm"
    "big-parallel"
    "gccarch-znver2"
  ];

  hardware.opengl = {
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

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  programs.auto-cpufreq.enable = false;
}
