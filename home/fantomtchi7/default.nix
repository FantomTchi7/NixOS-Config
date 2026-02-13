{ pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ../../modules/home/cli
    ../../modules/home/desktop/hyprland
    ../../modules/home/software/creative.nix
    ../../modules/home/software/media.nix
    ../../modules/home/software/internet.nix
    ../../modules/home/software/development.nix
  ];

  home.username = "fantomtchi7";
  home.homeDirectory = "/home/fantomtchi7";
  home.stateVersion = "25.11";

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = [ "/home/fantomtchi7/.ssh/id_ed25519" ]; 
  };
  
  programs.home-manager.enable = true;
}