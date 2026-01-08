{ inputs, ... }:
{
  programs.nh = {
    enable = true;
    flake = "/home/fantomtchi7/NixOS-Config";
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
}