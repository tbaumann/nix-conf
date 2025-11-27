{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  ###################################################################################
  #
  #  NixOS's core configuration suitable for my desktop computer
  #
  ###################################################################################

  imports = [
    ./desktops
    # ./syncthing.nix
    ../home-manager/default.nix
    ./mullvad.nix
    ./music.nix
    ./work/secunet
  ];

  nixpkgs.overlays = [inputs.nix-topology.overlays.default];

  boot.plymouth.enable = true;

  # add user's shell into /etc/shells
  environment.shells = with pkgs; [
    bash
    fish
  ];
  # set user's default shell system-wide
  users.defaultUserShell = pkgs.fish;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    appimage-run
    ghostscript
    inkscape-with-extensions
    kanshi
    libreoffice
    psmisc # killall/pstree/prtstat/fuser/...
    pulseaudio # provides `pactl`, which is required by some apps(e.g. sonic-pi)
    restique
    simple-scan
    speedtest-cli
    tsukimi
    thunderbird
    wev
    wine
    zathura
  ];

  services.gnome.gcr-ssh-agent.enable = false;
  programs = {
    ssh.startAgent = true;
    # dconf is a low-level configuration system.
    dconf.enable = true;
    firefox.enable = true;
    ausweisapp.enable = true;
    ausweisapp.openFirewall = true;
    evince.enable = true;
  };

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  # Disable pulseaudio, it conflicts with pipewire too.
  services.pulseaudio.enable = false;

  hardware.graphics.enable = true;

  hardware.bluetooth.enable = true;
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
  services.blueman.enable = true;

  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  #Scanner
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [pkgs.hplipWithPlugin pkgs.sane-airscan];

  #QMK
  hardware.keyboard.qmk.enable = true;

  # security with polkit
  security.polkit.enable = true;
  # security with gnome-kering
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;
    printing.cups-pdf.enable = true;

    # dbus.packages = [pkgs.gcr];
    geoclue2.enable = true;

    udev.packages = with pkgs; [
      gnome-settings-daemon
      platformio # udev rules for platformio
      openocd # required by paltformio, see https://github.com/NixOS/nixpkgs/issues/224895
    ];
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;
    wlr.enable = true;
  };

  fonts = {
    # use fonts specified by user rather than default ones
    fontconfig.enable = true;
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome
      corefonts
      open-fonts
      liberation_ttf

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji

      source-sans
      source-serif
      source-han-sans
      source-han-serif

      nerd-fonts._0xproto
      nerd-fonts.droid-sans-mono
    ];
  };
}
