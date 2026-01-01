{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix

    ./hardware-setup.nix

    ../../modules/core.nix

    ../../modules/cachyos.nix

    ../../modules/pipewire.nix

    ../../modules/hyprland.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  networking.hostName = "YUV-PC";
  networking.hostId = "d780429d";
  system.stateVersion = "25.11";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.fantomtchi7 = import ../../home/fantomtchi7/home.nix;
  };
}
