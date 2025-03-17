# This is the main system configuration file for NixOS
# Documentation: `man configuration.nix` or `nixos-help`

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Boot Configuration
  boot = {
    kernelParams = [ "intel_iommu=on" ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        useOSProber = true;
        efiSupport = true;
      };
    };
  };

  # Time Settings
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Copenhagen";
  };

  # Networking
  networking = {
    hostName = "mlnnix";
    networkmanager.enable = true;
    # Uncomment if needed:
    # wireless.enable = true;
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Internationalization
  i18n = {
    defaultLocale = "en_DK.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "da_DK.UTF-8";
      LC_IDENTIFICATION = "da_DK.UTF-8";
      LC_MEASUREMENT = "da_DK.UTF-8";
      LC_MONETARY = "da_DK.UTF-8";
      LC_NAME = "da_DK.UTF-8";
      LC_NUMERIC = "da_DK.UTF-8";
      LC_PAPER = "da_DK.UTF-8";
      LC_TELEPHONE = "da_DK.UTF-8";
      LC_TIME = "da_DK.UTF-8";
    };
  };

  # Desktop Environment
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "dk";
        variant = "";
      };
    };
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    printing.enable = true;
    teamviewer.enable = true;
  };

  # Console
  console.keyMap = "dk-latin1";

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # Uncomment for JACK support:
    # jack.enable = true;
  };

  # Virtualization
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  # User Configuration
  users.users.mln = {
    isNormalUser = true;
    description = "mln";
    extraGroups = [ "networkmanager" "wheel" "wireshark" "docker" "libvirtd" "kvm" ];
    shell = pkgs.zsh;
  };

  # Programs
  programs = {
    partition-manager.enable = true;
    firefox.enable = true;
    zsh.enable = true;
    virt-manager.enable = true;
  };

  # Nix Settings
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    allowed-users = [ "@wheel" ];
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    # Editors
    vim
    # Networking
    wget
    nmap
    bind
    inetutils
    # Development
    git
    python3
    pipx
    gh
    gcc
    gnumake
    cmake
    rustup
    # Terminal
    ghostty
    picocom
    tmux
    htop
    direnv
    neofetch
    # Virtualization
    virt-manager
    qemu_kvm
    libvirt
    virt-viewer
    spice-gtk
    virtio-win
    # Utilities
    exfatprogs
    pciutils
    systemdUkify
  ];

  # System Version
  system.stateVersion = "24.11";
}