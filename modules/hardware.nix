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
      nvidia-vaapi-driver
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
  boot.extraModprobeConfig = ''
    options nvidia_modeset vblank_sem_control=0
    options nvidia NVreg_UsePageAttributeTable=1
    options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/var/tmp
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

  services.xserver.videoDrivers = [ "nvidia" ];
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

  environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      WLR_NO_HARDWARE_CURSORS = "1";
      NVD_BACKEND = "direct";
    };

  ########################
  ## Bluetooth
  ########################
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
