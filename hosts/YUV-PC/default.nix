{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    "${inputs.nixos-hardware}/gigabyte/b550"
    "${inputs.nixos-hardware}/common/cpu/amd/pstate.nix"
    "${inputs.nixos-hardware}/common/cpu/amd/zenpower.nix"
    "${inputs.nixos-hardware}/common/pc"

    ../../modules/nixos/core

    ../../modules/nixos/hardware/gpu.nix
    ../../modules/nixos/hardware/zfs.nix

    ../../modules/nixos/features/gaming.nix
    ../../modules/nixos/features/sound.nix
    ../../modules/nixos/features/obs.nix
    ../../modules/nixos/features/hyprland.nix
    ../../modules/nixos/features/docker.nix
    ../../modules/nixos/features/flatpak.nix
    ../../modules/nixos/features/fonts.nix
  ];

  networking.hostName = "YUV-PC";
  networking.hostId = "d780429d";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl = {
    "vm.swappiness" = 60;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
  };

  system.stateVersion = "25.11";
}