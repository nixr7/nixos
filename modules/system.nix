{
  pkgs,
  nix-cachyos-kernel,
  ...
}:
{
  ########################
  ## CachyOS Kernel
  ########################
  nixpkgs.overlays = [
    nix-cachyos-kernel.overlays.pinned
  ];

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;

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
  programs.nix-ld.enable = true;
  services.irqbalance.enable = true;

  # CPUFreq
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

  # ZRAM
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  #services.ananicy = {
  #  enable = true;
  #  package = pkgs.ananicy-cpp;
  # };

  # Params
  boot.kernelParams = [
    "quiet"
    "splash"
    "nowatchdog"
    "nmi_watchdog=0"
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Flatpak
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
    auto-optimise-store = true;
    trusted-users = [
      "root"
      "max"
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nix.optimise.automatic = true;

  # Version
  system.stateVersion = "26.11";
}
