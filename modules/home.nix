{
  ...
}:

{
  home.username = "max";
  home.homeDirectory = "/home/max";
  programs.git.enable = true;
  programs.home-manager.enable = true;
  home.stateVersion = "26.11";
  programs.bash = {
    enable = true;
    shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    mynix = "sudo nvim /etc/nixos/nixos-config";
    clean = "sudo nix-collect-garbage -d";
    boot = "sudo /run/current-system/bin/switch-to-configuration boot";
    };
  };
}
