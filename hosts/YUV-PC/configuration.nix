{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/core.nix

    ../../modules/zram.nix

    ../../modules/gpu.nix

    ../../modules/cachyos.nix

    ../../modules/pipewire.nix

    ../../modules/hyprland.nix
  ];

  networking.hostName = "YUV-PC";
  networking.hostId = "d780429d";

  system.stateVersion = "25.11";
}
