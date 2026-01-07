{ pkgs, inputs, self, ... }:

{
  imports = [
    ./hardware.nix
    ./hardware-setup.nix

    "${inputs.nixos-hardware}/gigabyte/b550"
    "${inputs.nixos-hardware}/common/cpu/amd"
    "${inputs.nixos-hardware}/common/cpu/amd/pstate.nix"
    "${inputs.nixos-hardware}/common/cpu/amd/zenpower.nix"
    "${inputs.nixos-hardware}/common/pc"

    ../../modules/nixos/core.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/hyprland.nix
  ];

  networking.hostName = "YUV-PC";
  networking.hostId = "d780429d";
  system.stateVersion = "25.11";
}
