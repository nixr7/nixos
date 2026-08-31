{
  pkgs,
  ...
}:

{
  # X Server
  services.xserver.enable = true;

  # Display Manager
  services.displayManager.gdm.enable = true;

  # Desktop Environment
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
  epiphany
  gnome-software
];

  environment.systemPackages = with pkgs; [
  gnome-tweaks
];

  programs.dconf.enable = true;

  # PipeWire
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    ibm-plex
    noto-fonts
    noto-fonts-color-emoji
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MUTTER_DEBUG_ENABLE_THREADED_SWAP = "1";
  };

  # XDG Portal
  xdg.portal = {
    enable = true;

    xdgOpenUsePortal = true;
  };
}
