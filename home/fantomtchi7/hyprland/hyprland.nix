{ pkgs, ... }:

{
  programs.firefox.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  home.packages = [
    pkgs.kdePackages.dolphin
    fooyin
  ];
}
