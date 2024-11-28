{
  pkgs,
  inputs,
  ...
}: {
  programs.nix-index.enable = true;
  home.packages = with pkgs; [
    act
    alejandra
    baobab
    bitwarden
    bitwarden-cli
    cmake
    du-dust
    entr
    epiphany
    file
    adwaita-icon-theme
    dconf-editor
    eog
    gnome-system-monitor
    nautilus
    grim
    gtk4
    intel-gpu-tools
    lftp
    lshw
    mullvad-vpn
    networkmanagerapplet
    ninja
    nodejs
    nvd
    openrazer-daemon
    optipng
    pavucontrol
    pciutils # For lspci
    polychromatic
    pre-commit
    razergenie
    rink
    scc
    slurp
    swaylock-effects
    usbutils # For lsusb
    vlc
    wget
    wl-clip-persist
    wl-clipboard
    xdg-user-dirs
    yarn
  ];
}
