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
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  boot.extraModulePackages = [];
  virtualisation.libvirtd.enable = true;
  nix.settings.system-features = [
    "kvm"
    "big-parallel"
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
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
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
