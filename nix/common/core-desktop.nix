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
    ./syncthing.nix
  ];

  # to install chrome, you need to enable unfree packages
  nixpkgs.config.allowUnfree = lib.mkForce true;

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
    # python, some times I may need to use python with root permission.
    python3Full
    psmisc # killall/pstree/prtstat/fuser/...
    pulseaudio # provides `pactl`, which is required by some apps(e.g. sonic-pi)
    libreoffice
    wev
    betterbird
    thunderbird
    restique
    kanshi
    wine
  ];

  programs = {
    # The OpenSSH agent remembers private keys for you
    # so that you don’t have to type in passphrases every time you make an SSH connection.
    # Use `ssh-add` to add a key to the agent.
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
  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  sound.enable = false;
  # Disable pulseaudio, it conflicts with pipewire too.
  hardware.pulseaudio.enable = false;

  hardware.opengl.enable = true;

  hardware.bluetooth.enable = true;
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
  services.blueman.enable = true;

  # security with polkit
  services.power-profiles-daemon = {
    enable = true;
  };
  security.polkit.enable = true;
  # security with gnome-kering
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;
    printing.cups-pdf.enable = true;

    # https://flatpak.org/setup/NixOS
    flatpak.enable = true;

    dbus.packages = [pkgs.gcr];
    geoclue2.enable = true;

    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
      platformio # udev rules for platformio
      openocd # required by paltformio, see https://github.com/NixOS/nixpkgs/issues/224895
      android-udev-rules
    ];
  };

  xdg.portal = {
    enable = true;
    # Sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1
    # This will make xdg-open use the portal to open programs,
    # which resolves bugs involving programs opening inside FHS envs or with unexpected env vars set from wrappers.
    # xdg-open is used by almost all programs to open a unknown file/uri
    # alacritty as an example, it use xdg-open as default, but you can also custom this behavior
    # and vscode has open like `External Uri Openers`
    xdgOpenUsePortal = false;
    wlr.enable = true;
  };

  # all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
  fonts = {
    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra

      source-sans
      source-serif
      source-han-sans
      source-han-serif

      # nerdfonts
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
        ];
      })
    ];

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  environment.variables = {
    # fix https://github.com/NixOS/nixpkgs/issues/238025
    TZ = "${config.time.timeZone}";
  };
}
