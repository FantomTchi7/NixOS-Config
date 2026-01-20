{ pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ../../modules/home/cli
    ../../modules/home/desktop/hyprland
    ../../modules/home/desktop/development
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