{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # AMD RX 6900 XT + Nvidia GTX 1050 Ti
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.amdgpu.initrd.enable = true;

  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;

  # NVME SSD
  services.fstrim.enable = true;

  # 32 GB RAM
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  # Kernel
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
  
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;

  # Secret
  time.timeZone = "Europe/Tallinn";
  networking.hostName = "YUV-PC";
  users.users.fantomtchi7 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "1987";
    # packages = with pkgs; [
    #   tree
    # ];
  };

  # Sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    vim
  ];

  # System
  system.stateVersion = "26.05";
}

