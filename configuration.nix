# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-21.4.0"
  ];

  boot = {
    # Use the systemd-boot EFI boot loader
    loader = {
      efi.canTouchEfiVariables = false;
      # Timeout in seconds. Use null if display should play indefinetly.
      timeout = 5;
      systemd-boot = {
        enable = true;
        # Maximum number of generations
        configurationLimit = 5;
        # Wheter to allow editing the kernel command-line before boot.
        # Recommended to turn this off.
        editor = false;
      };
    };
  };

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Network
  networking = {
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces = {
      enp4s0.useDHCP = true;
      wlp3s0.useDHCP = true;
    };
    # hostName = "nixos"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "es";
  };

  # Services
  services = {
    # X11 Server
    xserver = {
      enable = true;
      layout = "es";
      libinput.enable = true;

      # GNOME DE
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    # Enable CUPS to print documents.
    # printing.enable = true;

    # List services that you want to enable:
    flatpak.enable = true;
  };

  # Programs
  programs.zsh = {
    enable = true;
    promptInit = ''
      PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f %# '
    '';
  };

  programs.nano = {
    nanorc = builtins.readFile (./modules/nano/.nanorc);
    syntaxHighlight = true;
  };

  # Users. Don't forget to set a password with ‘passwd’.
  users.users.fedepujol = {
    isNormalUser = true;
    home = "/home/fedepujol";
    description = "fedepujol";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # Users default-shell zsh
  users.defaultUserShell = pkgs.zsh;

  # List packages default
  environment = {
    # Some programs to determine if a user is "normal" or "system"
    # use the /etc/shells. It's recommended to add the shell.
    shells = with pkgs; [ zsh ];
    # System-wide packages
    systemPackages = with pkgs; [
      # CLI
      gcc
      nix-prefetch-scripts
      (python310.withPackages (ps: with ps; [
        numpy
        matplotlib
      ]
      ))

      # GUI
      firefox
      gnome.gnome-tweaks
      veracrypt
      obsidian
      rustup
    ];

    # Enviroment variables
    variables.EDITOR = "nvim";
  };

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [ "FiraCode" "Ubuntu" ];
    })
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

  nix = {
    # Automatically run the garbage collector
    gc.automatic = true;

    # Automatically detects files in the store with identical contents,
    # and replaces them with hard links to a single copy.
    settings = {
      auto-optimise-store = true;
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}

