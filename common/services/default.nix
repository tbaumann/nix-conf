{...}: {
  imports = [
    ./docker.nix
    ./homepage.nix
    ./libvirt.nix
    ./lorri.nix
    ./openvpn.nix
  ];
  services.ollama = {
    enable = true;
    acceleration = "vulkan";
    loadModels = ["qwen2.5-coder" "qwen3-coder" "gemma3"];
  };
}
