{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system.nix
    ../../modules/hardware.nix
    ../../modules/desktop.nix
    ../../modules/programs.nix
    ../../modules/brave-policies.nix
    #../../modules/virtualisation.nix
  ];
}
