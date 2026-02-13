{ inputs, pkgs, ... }:
{
  programs.nh = {
    enable = true;
    flake = "/home/fantomtchi7/NixOS-Config";
  };
  
  programs.nix-ld.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];
}
