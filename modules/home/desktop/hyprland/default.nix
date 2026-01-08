{ pkgs, ... }:

{
  xdg.configFile."uwsm/env-hyprland".text = ''
    export AQ_DRM_DEVICES=/dev/dri/card1:/dev/dri/card0
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  systemd.user.services.hyprpolkitagent = {
    Unit = {
      Description = "Hyprland Polkit Authentication Agent";
    };

    Service = {
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
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
    xdg-user-dirs
    kdePackages.dolphin
    kdePackages.qt6ct
    nwg-look
    fooyin
    photoqt
    haruna
    ghostty
    legcord
    spotify
    blender
    gimp
    inkscape
  ];
}
