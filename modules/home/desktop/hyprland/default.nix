{ pkgs, ... }:

{
  xdg.configFile."uwsm/env-hyprland".text = ''
    export AQ_DRM_DEVICES=/dev/dri/card1:/dev/dri/card0
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      kdePackages.xdg-desktop-portal-kde
    ];
  };

  programs.firefox.enable = true;

  home.packages = with pkgs; [
    hyprpolkitagent
    xdg-user-dirs
    playerctl
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.qt6ct
    lxqt.pavucontrol-qt
    nwg-look
    fooyin
    photoqt
    haruna
    ghostty
    qbittorrent
    vesktop
    spotify
    blender
    gimp
    inkscape
  ];
}