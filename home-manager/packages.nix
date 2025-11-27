{
  pkgs,
  inputs,
  ...
}: {
  programs.nix-index.enable = true;
  home.packages = with pkgs; [
    act
    adwaita-icon-theme
    alejandra
    baobab
    bitwarden-desktop
    bitwarden-cli
    cmake
    dconf-editor
    dust
    entr
    eog
    epiphany
    file
    fractal
    gnome-system-monitor
    grim
    gtk4
    intel-gpu-tools
    lftp
    lshw
    mullvad-vpn
    nautilus
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
    scc
    slurp
    swaylock-effects
    tsukimi
    usbutils # For lsusb
    vlc
    wget
    wl-clip-persist
    wl-clipboard
    xdg-user-dirs
    yarn
  ];
}
