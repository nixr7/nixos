{
  pkgs,
  ...
}:

{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];
    policies = {
      DisableTelemetry = true;
    };
  };

  environment.systemPackages = with pkgs; [
    bat
    btop
    curl
    git
    wget
    eza
    fastfetch
    fzf
    neovim
    p7zip
    tree
    unzip
    usbutils
    alacritty
    lenovo-legion
    brave
    discord
    zed-editor
    vlc
    ayugram-desktop
  ];
}
