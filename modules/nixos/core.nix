{ pkgs, inputs, ... }:

{
  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";

  services.udisks2.enable = true;

  networking.networkmanager.enable = true;

  programs.fish.enable = true; 

  users.users.fantomtchi7 = {
    description = "FantomTchi7";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
  };

  virtualisation.docker = {
    enable = true;
  };

  programs.nh = {
    enable = true;
    flake = "/home/fantomtchi7/NixOS-Config";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
}
