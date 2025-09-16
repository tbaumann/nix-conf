{pkgs, ...}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      runAsRoot = true;
      ovmf = {
        enable = true;
      };
    };
  };
  programs.virt-manager.enable = true;
}
