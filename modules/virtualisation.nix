{
  pkgs,
  ...
}:

{
  ########################
  ## Docker
  ########################

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  ########################
  ## Libvirt
  ########################

  virtualisation.libvirtd.enable = true;

  ########################
  ## Virt-Manager
  ########################

  programs.virt-manager.enable = true;

  ########################
  ## SPICE
  ########################

  virtualisation.spiceUSBRedirection.enable = true;
}
