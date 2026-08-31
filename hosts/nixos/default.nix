{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system.nix
    ../../modules/hardware.nix
    ../../modules/desktop.nix
    #../../modules/virtualisation.nix
    ../../modules/programs.nix
  ];
}
