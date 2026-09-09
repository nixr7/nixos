{ pkgs, nix-cachyos-kernel, ... }:

{
  ########################
  ## CachyOS Kernel
  ########################

  nixpkgs.overlays = [
    nix-cachyos-kernel.overlays.pinned
  ];

  boot.kernelPackages =
    pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;

  ########################
  ## Boot
  ########################

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.timeout = 5;
  boot.tmp.cleanOnBoot = true;

  ########################
  ## Networking
  ########################

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  ########################
  ## Time
  ########################

  time.timeZone = "Asia/Baghdad";

  ########################
  ## Locale
  ########################

  i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

  ########################
  ## Console
  ########################

  console.keyMap = "us";

  ########################
  ## User
  ########################

  users.users.max = {
    isNormalUser = true;

    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  ########################
  ## Security
  ########################

  networking.firewall.enable = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;

  ########################
  ## Firmware
  ########################

  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable = true;

  ########################
  ## Performance
  ########################

  services.fstrim.enable = true;

  services.power-profiles-daemon.enable = false;

  services.auto-cpufreq = {
    enable = true;

    settings = {
      charger = {
        governor = "performance";
        turbo = "auto";
      };

      battery = {
        governor = "balanced";
        turbo = "auto";
      };
    };
  };

  programs.nix-ld.enable = true;

  services.irqbalance.enable = true;

  ########################
  ## ZRAM
  ########################

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  ########################
  ## Kernel Parameters
  ########################

  boot.kernelParams = [
    "quiet"
    "splash"
  ];

  ########################
  ## Wayland / Electron
  ########################

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  ########################
  ## Flatpak
  ########################

  services.flatpak.enable = true;

  ########################
  ## Nix
  ########################

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://cosmic.cachix.org/"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCUSeBw="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];

    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nix.optimise.automatic = true;


  ########################
  ## Version
  ########################

  system.stateVersion = "26.11";
}
