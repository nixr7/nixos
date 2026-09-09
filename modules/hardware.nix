{
  pkgs,
  config,
  ...
}:
{
  ########################
  ## Graphics
  ########################
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
    ];
  };

  ########################
  ## Intel CPU
  ########################
  hardware.cpu.intel.updateMicrocode = true;

  ########################
  ## NVIDIA
  ########################
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    ########################
    ## PRIME Offload
    ########################
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };
  hardware.nvidia.dynamicBoost.enable = true;

  ########################
  ## NVIDIA options
  ########################

    boot.extraModprobeConfig = ''
      options nvidia_modeset vblank_sem_control=0
      options nvidia NVreg_UsePageAttributeTable=1
      options nvidia NVreg_PreserveVideoMemoryAllocations=1
      options nvidia NVreg_TemporaryFilePath=/var/tmp
    '';

    boot.kernelModules = [
      "nvidia_uvm"
      "nvidia_modeset"
      "nvidia_drm"
      "nvidia"
    ];

    boot.kernelParams = [
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];

  # Blocklist Nouveau
  boot.blacklistedKernelModules = [ "nouveau" ];

  ########################
  ## Bluetooth
  ########################
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
