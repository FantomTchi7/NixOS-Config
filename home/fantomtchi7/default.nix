{ pkgs, ... }:

{
  imports = [
    ./features/cli
    ./features/hyprland
  ];

  home.username = "fantomtchi7";
  home.homeDirectory = "/home/fantomtchi7";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
