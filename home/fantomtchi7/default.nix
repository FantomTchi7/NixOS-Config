{ pkgs, ... }:

{
  imports = [
    ../../modules/home/cli
    ../../modules/home/desktop/hyprland
    ../../modules/home/desktop/obs
    ../../modules/home/desktop/development
  ];

  home.username = "fantomtchi7";
  home.homeDirectory = "/home/fantomtchi7";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}