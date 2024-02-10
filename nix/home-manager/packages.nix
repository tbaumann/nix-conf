{
  pkgs,
  inputs,
  ...
}: {
  programs.nix-index.enable = true;
  home.packages = with pkgs; [
    act
    alejandra
    alsa-utils # For alsamixer
    baobab
    #clang-tools # For clang-format
    cmake
    deno
    epiphany
    file
    gnome.adwaita-icon-theme
    gnome.dconf-editor
    gnome.eog
    gnome.gnome-system-monitor
    gnome.nautilus
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
    optipng
    pavucontrol
    pciutils # For lspci
    (poetry.withPlugins (ps:
      with ps; [
        poetry-plugin-up
      ]))
    pre-commit
    prismlauncher
    scc
    slurp
    swaylock-effects
    thefuck
    usbutils # For lsusb
    vlc
    wget
    wl-clipboard
    wl-clip-persist
    xdg-user-dirs
    yarn
    razergenie
    polychromatic
    openrazer-daemon
    bitwarden
    bitwarden-cli
    rink
  ];
}
