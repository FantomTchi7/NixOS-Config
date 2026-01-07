{ pkgs, inputs, self, ... }:

{
  imports = [
    ./hardware.nix
    ./hardware-setup.nix

    ../../modules/nixos/core.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/hyprland.nix
  ];

  networking.hostName = "YUV-PC";
  networking.hostId = "d780429d";
  system.stateVersion = "25.11";
}
