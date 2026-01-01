{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  xdg.configFile."uwsm/env-hyprland".text = ''
    export AQ_DRM_DEVICES=/dev/dri/card1:/dev/dri/card0
  '';

  programs.firefox.enable = true;

  home.packages = [
    pkgs.kdePackages.qt6ct
    pkgs.kdePackages.dolphin
    pkgs.fooyin
    pkgs.ghostty
  ];
}
