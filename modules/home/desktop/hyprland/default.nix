{ pkgs, ... }:

{
  xdg.configFile."uwsm/env-hyprland".text = ''
    export AQ_DRM_DEVICES=/dev/dri/card1:/dev/dri/card2
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

  home.packages = with pkgs; [
    hyprshot
    hyprpolkitagent
    xdg-user-dirs
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.qt6ct
    nwg-look
    fooyin
    ghostty
  ];
}
